<?php

	include_once(EXTENSIONS . '/typography/lib/typography/php-typography/php-typography.php');

	class englishTypography extends phpTypography {
	
		static function about() {
			return array(
				'title' => __('English Typography'),
				'handle' => 'english'
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
			$this->set_smart_quotes(true);
			$this->set_smart_quotes_primary();
			$this->set_smart_quotes_secondary();
			$this->set_smart_dashes();
			$this->set_smart_ellipses();
			$this->set_smart_diacritics(false);
			$this->set_smart_marks();
			$this->set_smart_ordinal_suffix();
			$this->set_smart_math();
			$this->set_smart_fractions(false);
			$this->set_smart_exponents();
			
			// Smart spacing
			$this->set_single_character_word_spacing();
			$this->set_fraction_spacing();
			$this->set_unit_spacing();
			$this->set_dash_spacing(false);
			$this->set_dewidow();
			$this->set_max_dewidow_length();
			$this->set_max_dewidow_pull();
			$this->set_wrap_hard_hyphens(false);
			$this->set_url_wrap(false);
			$this->set_email_wrap(false);
			$this->set_space_collapse();
			
			// Character styling
			$this->set_style_ampersands(false);
			$this->set_style_caps(false);
			$this->set_style_initial_quotes(false);
			$this->set_style_numbers(false);
			
			// Hyphenation
			$this->set_hyphenation(false);
			
			return TRUE;
		}
				
	}