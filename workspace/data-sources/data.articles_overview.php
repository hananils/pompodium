<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcearticles_overview extends SectionDatasource {

		public $dsParamROOTELEMENT = 'articles-overview';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '5';
		public $dsParamSTARTPAGE = '{$url-page}';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamPARAMOUTPUT = array(
				'system:id'
		);
		public $dsParamSORT = 'date';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		

		public $dsParamFILTERS = array(
				'system:id' => 'not: {$ds-articles-current.system-id}',
				'1' => '{$title}',
				'27' => '{$author}',
				'4' => '{$year:1970}-{$month:01}-01 to {$year:2100}-{$month:12}-31',
				'14' => '{$category}',
				'24' => 'published',
		);
		

		public $dsParamINCLUDEDELEMENTS = array(
				'system:pagination',
				'title',
				'cover-image',
				'introduction: formatted',
				'author',
				'date',
				'category'
		);
		

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array('$ds-articles-current.system-id');
		}

		public function about() {
			return array(
				'name' => 'Articles: Overview',
				'author' => array(
					'name' => 'Nils Hörrmann',
					'website' => 'http://webseiten/pompodium2',
					'email' => 'buero@hananils.de'),
				'version' => 'Symphony 2.3.3',
				'release-date' => '2013-08-13T12:49:10+00:00'
			);
		}

		public function getSource() {
			return '1';
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
