<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourcearticle extends Datasource{
		
		public $dsParamROOTELEMENT = 'article';
		public $dsParamORDER = 'desc';
		public $dsParamLIMIT = '1';
		public $dsParamREDIRECTONEMPTY = 'yes';
		public $dsParamSORT = 'date';
		public $dsParamSTARTPAGE = '1';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'yes';
		
		public $dsParamFILTERS = array(
				'1' => '{$title}',
				'19' => 'Published',
		);
		
		public $dsParamINCLUDEDELEMENTS = array(
				'title',
				'cover-picture',
				'body: formatted',
				'authors',
				'date',
				'category',
				'tags',
				'comments',
				'images'
		);

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}
		
		public function about(){
			return array(
					 'name' => 'Article',
					 'author' => array(
							'name' => 'Nils Hörrmann',
							'website' => 'http://projekte.nilshoerrmann.de/pompodium',
							'email' => 'post@nilshoerrmann.de'),
					 'version' => '1.0',
					 'release-date' => '2010-05-08T06:01:37+00:00');	
		}
		
		public function getSource(){
			return '1';
		}
		
		public function allowEditorToParse(){
			return true;
		}
		
		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);
				
			try{
				include(TOOLKIT . '/data-sources/datasource.section.php');
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}			
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}	

			if($this->_force_empty_result) $result = $this->emptyXMLSet();
			return $result;
		}
	}

