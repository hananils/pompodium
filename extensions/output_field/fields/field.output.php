<?php

	if (!defined('__IN_SYMPHONY__')) die('<h2>Symphony Error</h2><p>You cannot directly access this file</p>');

	require_once(TOOLKIT . '/fields/field.input.php');

	class FieldOutput extends FieldInput {

		public function __construct(&$parent){
			parent::__construct($parent);
			$this->_name = __('Text Output');
			$this->_required = true;
			
			$this->set('required', 'no');
		}

		function appendFormattedElement(&$wrapper, $data, $encode=false){
			
			include(TOOLKIT . '/util.validators.php');

			if($this->get('apply_formatting') == 'yes' && isset($data['value_formatted'])) $value = $data['value_formatted'];
			else $value = $data['value'];
			
			$value = General::sanitize($value);

			if($this->get('validator') == $validators['email']) {
				$mail = explode('@', $value);
				$attributes = array(
					'alias' => $mail[0],
					'domain' => $mail[1],
					'hash' => md5(strtolower($value))
				);
 			}
			elseif($this->get('validator') == $validators['URI']) {
				$attributes = parse_url($value);
			}
 			else {
				$attributes = array(
					'handle' => $data['handle']
				);
 			}
			
			$wrapper->appendChild(new XMLElement($this->get('element_name'), ($encode ? General::sanitize($value) : $value), $attributes));
		}
		
	}
