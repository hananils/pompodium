<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourceCategories extends Datasource{
		
		var $dsParamROOTELEMENT = 'categories';
		var $dsFieldID = '17';
		
		function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}
		
		function about(){
			return array(
					 'name' => 'Categories',
					 'author' => array(
							'name' => 'Nils Hörrmann',
							'website' => 'http://www.nilshoerrmann.de',
							'email' => 'post@nilshoerrmann.de'),
					 'version' => '1.0',
					 'release-date' => '2009-04-15T20:00:00+00:00');	
		}
		
		function grab(&$param_pool){
			$result = NULL;

			$sql = "SELECT DISTINCT `value` FROM `tbl_entries_data_" . $this->dsFieldID . "` 
					ORDER BY `value` ASC";
			$tags = $this->_Parent->Database->fetchCol('value', $sql);

			$result = new XMLElement($this->dsParamROOTELEMENT);
			foreach($tags as $tag){
				$result->appendChild(
					new XMLElement(
						'item', 
						General::sanitize($tag), 
						array(
							'handle' => Lang::createHandle($tag)
						)
					)
				);
			}

			return $result;
		}
	}

?>