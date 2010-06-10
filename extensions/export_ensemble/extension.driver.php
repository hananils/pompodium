<?php

	Class extension_export_ensemble extends Extension{

		public function about(){
			return array('name' => 'Export Ensemble',
						 'version' => '1.11',
						 'release-date' => '2010-02-12',
						 'author' => array('name' => 'Alistair Kearney',
										   'website' => 'http://pointybeard.com',
										   'email' => 'alistair@pointybeard.com')
				 		);
		}
		
		public function getSubscribedDelegates(){
			return array(
						array(
							'page' => '/system/preferences/',
							'delegate' => 'AddCustomPreferenceFieldsets',
							'callback' => 'appendPreferences'
						),

					);
		}
		
		public function install(){
			
			if(!class_exists('ZipArchive')){
				Administration::instance()->Page->pageAlert(__('Export Ensemble cannot be installed, since the "<a href="http://php.net/manual/en/book.zip.php">ZipArchive</a>" class is not available. Ensure that PHP was compiled with the <code>--enable-zip</code> flag.'), AdministrationPage::PAGE_ALERT_ERROR);
				return false;
			}
			
			return true;
		}
		
		private function __addFolderToArchive(&$archive, $path, $parent=NULL){
			$iterator = new DirectoryIterator($path);
			foreach($iterator as $file){
				if($file->isDot() || preg_match('/^\./', $file->getFilename())) continue;
				
				elseif($file->isDir()){
					$this->__addFolderToArchive($archive, $file->getPathname(), $parent);
				}

				else $archive->addFile($file->getPathname(), ltrim(str_replace($parent, NULL, $file->getPathname()), '/'));
			}
		}
		
		private function __export(){
			$sql_schema = $sql_data = NULL;
			
			require_once(dirname(__FILE__) . '/lib/class.mysqldump.php');
			
			$dump = new MySQLDump(Symphony::Database());

			$tables = array(
				'tbl_authors',
				'tbl_cache',
				'tbl_entries',
				'tbl_extensions',
				'tbl_extensions_delegates',
				'tbl_fields',
				'tbl_fields_%',			
				'tbl_forgotpass',
				'tbl_pages',
				'tbl_pages_types',
				'tbl_sections',
				'tbl_sections_association'			
			);
			
			## Grab the schema
			foreach($tables as $t) $sql_schema .= $dump->export($t, MySQLDump::STRUCTURE_ONLY);
			$sql_schema = str_replace('`' . Administration::instance()->Configuration->get('tbl_prefix', 'database'), '`tbl_', $sql_schema);
			
			$sql_schema = preg_replace('/AUTO_INCREMENT=\d+/i', NULL, $sql_schema);
			
			$tables = array(
				'tbl_entries',
				'tbl_extensions',
				'tbl_extensions_delegates',
				'tbl_fields',			
				'tbl_pages',
				'tbl_pages_types',
				'tbl_sections',
				'tbl_sections_association'			
			);			
			
			## Field data and entry data schemas needs to be apart of the workspace sql dump
			$sql_data  = $dump->export('tbl_fields_%', MySQLDump::ALL);
			$sql_data .= $dump->export('tbl_entries_%', MySQLDump::ALL);
			
			## Grab the data
			foreach($tables as $t){
				$sql_data .= $dump->export($t, MySQLDump::DATA_ONLY);
			}
			
			$sql_data = str_replace('`' . Administration::instance()->Configuration->get('tbl_prefix', 'database'), '`tbl_', $sql_data);
			
			$config_string = NULL;
			$config = Administration::instance()->Configuration->get();	
			
			unset($config['symphony']['build']);
			unset($config['symphony']['cookie_prefix']);
			unset($config['general']['useragent']);
			unset($config['file']['write_mode']);
			unset($config['directory']['write_mode']);
			unset($config['database']['host']);
			unset($config['database']['port']);
			unset($config['database']['user']);
			unset($config['database']['password']);
			unset($config['database']['db']);
			unset($config['database']['tbl_prefix']);
			unset($config['region']['timezone']);

			foreach($config as $group => $set){
				foreach($set as $key => $val){
					$config_string .= "		\$conf['{$group}']['{$key}'] = '{$val}';" . self::CRLF;
				}
			}
			
			$install_template = str_replace(
				
									array(
										'<!-- BUILD -->',
										'<!-- VERSION -->',
										'<!-- CONFIGURATION -->'
									),
				
									array(
										Administration::instance()->Configuration->get('build', 'symphony'),
										Administration::instance()->Configuration->get('version', 'symphony'),
										trim($config_string),										
									),
				
									file_get_contents(dirname(__FILE__) . '/lib/installer.tpl')
			);
			
			$archive = new ZipArchive;
			$res = $archive->open(TMP . '/ensemble.tmp.zip', ZipArchive::CREATE);

			if ($res === TRUE) {
				
				$this->__addFolderToArchive($archive, EXTENSIONS, DOCROOT);
				$this->__addFolderToArchive($archive, SYMPHONY, DOCROOT);
				$this->__addFolderToArchive($archive, WORKSPACE, DOCROOT);
				
				$archive->addFromString('install.php', $install_template);
				$archive->addFromString('install.sql', $sql_schema);
				$archive->addFromString('workspace/install.sql', $sql_data);
				
				$archive->addFile(DOCROOT . '/index.php', 'index.php');
				
				$readme_files = glob(DOCROOT . '/README.*');
				if(is_array($readme_files) && !empty($readme_files)){
					foreach($readme_files as $filename){
						$archive->addFile($filename, basename($filename));	
					}
				}
				
				if(is_file(DOCROOT . '/README')) $archive->addFile(DOCROOT . '/README', 'README');
				if(is_file(DOCROOT . '/LICENCE')) $archive->addFile(DOCROOT . '/LICENCE', 'LICENCE');
				if(is_file(DOCROOT . '/update.php')) $archive->addFile(DOCROOT . '/update.php', 'update.php');
					
			}
			
			$archive->close();

			header('Content-type: application/octet-stream');	
			header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
			
		    header(
				sprintf(
					'Content-disposition: attachment; filename=%s-ensemble.zip', 
					Lang::createFilename(
						Administration::instance()->Configuration->get('sitename', 'general')
					)
				)
			);
			
		    header('Pragma: no-cache');
		
			readfile(TMP . '/ensemble.tmp.zip');
			unlink(TMP . '/ensemble.tmp.zip');
			exit();
			
		}

		public function __SavePreferences($context){
			$this->__export();
		}
		
		public function appendPreferences($context){
			
			if(isset($_POST['action']['export'])){
				$this->__SavePreferences($context);
			}
			
			$group = new XMLElement('fieldset');
			$group->setAttribute('class', 'settings');
			$group->appendChild(new XMLElement('legend', __('Export Ensemble')));			
			

			$div = new XMLElement('div', NULL, array('id' => 'file-actions', 'class' => 'label'));			
			$span = new XMLElement('span');
			
			if(!class_exists('ZipArchive')){
				$span->appendChild(
					new XMLElement('p', '<strong>' . __('Warning: It appears you do not have the "ZipArchive" class available. Ensure that PHP was compiled with <code>--enable-zip</code>') . '<strong>')
				);
			}
			else{
				$span->appendChild(new XMLElement('button', __('Create'), array('name' => 'action[export]', 'type' => 'submit')));	
			}
			
			$div->appendChild($span);

			$div->appendChild(new XMLElement('p', __('Packages entire site as a <code>.zip</code> archive for download.'), array('class' => 'help')));	

			$group->appendChild($div);						
			$context['wrapper']->appendChild($group);
						
		}
	}