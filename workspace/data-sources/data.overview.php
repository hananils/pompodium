<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourceoverview extends Datasource{
		
		public $dsParamROOTELEMENT = 'overview';
		public $dsParamORDER = 'desc';
		public $dsParamLIMIT = '20';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamREQUIREDPARAM = '$title';
		public $dsParamSORT = 'system:id';
		public $dsParamSTARTPAGE = '1';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		
		public $dsParamFILTERS = array(
				'17' => '{$ds-category}',
				'19' => 'Published',
		);
		
		public $dsParamINCLUDEDELEMENTS = array(
				'title',
				'authors',
				'date'
		);

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array('$ds-category');
		}
		
		public function about(){
			return array(
					 'name' => 'Overview',
					 'author' => array(
							'name' => 'Nils Hörrmann',
							'website' => 'http://projekte.nilshoerrmann.de/pompodium',
							'email' => 'post@nilshoerrmann.de'),
					 'version' => '1.0',
					 'release-date' => '2010-05-02T14:38:15+00:00');	
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

