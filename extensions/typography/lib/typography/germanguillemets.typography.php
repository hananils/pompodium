<?php

	include_once(EXTENSIONS . '/typography/lib/typography/german.typography.php');

	class germanguillemetsTypography extends germanTypography {
	
		static function about() {
			return array(
				'title' => __('German Typography with Guillemets'),
				'handle' => 'germanguillemets'
			);
		}
		
		/**
		 * Set typografic rules
		 *
		 * See http://kingdesk.com/projects/php-typography-documentation/ for further information
		 */
		function set_defaults() {

			parent::set_defaults();

			// Smart characters
			$this->set_smart_quotes_primary('doubleGuillemetsReversed');
			$this->set_smart_quotes_secondary('singleGuillemetsReversed');
			
			return TRUE;
		}

	}
