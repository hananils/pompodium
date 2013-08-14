<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcearticles_media extends SectionDatasource {

		public $dsParamROOTELEMENT = 'articles-media';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '20';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		

		public $dsParamFILTERS = array(
				'system:id' => '{$ds-articles-current.media}, {$ds-articles-current.cover-image}, {$ds-pages.cover-image}',
		);
		

		public $dsParamINCLUDEDELEMENTS = array(
				'title',
				'author',
				'link',
				'file',
				'licence'
		);
		

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array('$ds-articles-current.media', '$ds-articles-current.cover-image', '$ds-pages.cover-image');
		}

		public function about() {
			return array(
				'name' => 'Articles: Media',
				'author' => array(
					'name' => 'Nils Hörrmann',
					'website' => 'http://webseiten/pompodium2',
					'email' => 'buero@hananils.de'),
				'version' => 'Symphony 2.3.3',
				'release-date' => '2013-08-14T08:41:21+00:00'
			);
		}

		public function getSource() {
			return '2';
		}

		public function allowEditorToParse() {
			return true;
		}

		public function execute(array &$param_pool = null) {
			$result = new XMLElement($this->dsParamROOTELEMENT);

			try{
				$result = parent::execute($param_pool);
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile()));
				return $result;
			}

			if($this->_force_empty_result) $result = $this->emptyXMLSet();

			return $result;
		}

	}
