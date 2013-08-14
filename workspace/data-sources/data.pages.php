<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcepages extends SectionDatasource {

		public $dsParamROOTELEMENT = 'pages';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '1';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamPARAMOUTPUT = array(
				'cover-image'
		);
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		

		public $dsParamFILTERS = array(
				'30' => '{$current-page}',
				'29' => 'published',
		);
		

		public $dsParamINCLUDEDELEMENTS = array(
				'title',
				'cover-image',
				'introduction: formatted',
				'body: formatted'
		);
		

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Pages',
				'author' => array(
					'name' => 'Nils Hörrmann',
					'website' => 'http://webseiten/pompodium2',
					'email' => 'buero@hananils.de'),
				'version' => 'Symphony 2.3.3',
				'release-date' => '2013-08-14T08:40:02+00:00'
			);
		}

		public function getSource() {
			return '5';
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
