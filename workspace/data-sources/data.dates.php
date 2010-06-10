<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourcedates extends Datasource{
		
		public $dsParamROOTELEMENT = 'dates';
		public $dsParamORDER = 'desc';
		public $dsParamGROUP = '16';
		public $dsParamLIMIT = '300';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'date';
		public $dsParamSTARTPAGE = '1';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}
		
		public function about(){
			return array(
					 'name' => 'Dates',
					 'author' => array(
							'name' => 'Nils Hörrmann',
							'website' => 'http://projekte.nilshoerrmann.de/pompodium',
							'email' => 'post@nilshoerrmann.de'),
					 'version' => '1.0',
					 'release-date' => '2010-05-02T10:55:41+00:00');	
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

