<?php

	Class contentAjaxTranslate extends AjaxPage{

		function __construct(&$parent){
			$this->_Parent = $parent;
			$this->_status = self::STATUS_OK;
			$this->addHeaderToPage('Content-Type', 'application/json');
			$this->_Parent->Profiler->sample('Page template created', PROFILE_LAP);	
		}
		
		public function handleFailedAuthorisation(){
			$this->_status = self::STATUS_UNAUTHORISED;
			$this->_Result = json_encode(array('status' => __('You are not authorised to access this page.')));
		}

		public function view(){
			$strings = $_GET;
			$new = array();		
			foreach($strings as $id => $string) {
				if($id == 'mode' || $id == 'symphony-page') continue;
				$string = urldecode($string);
				$new[$string] = __($string);
			}
			$this->_Result = json_encode($new);	
		}
		
		public function generate(){
			echo $this->_Result;
			exit;	
		}
				
	}

