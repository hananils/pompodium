<?php

	include_once(EXTENSIONS . '/typography/lib/typography/php-typography/php-typography.php');

	class germanTypography extends phpTypography {
	
		static function about() {
			return array(
				'title' => __('German Typography'),
				'handle' => 'german'
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
			$this->set_smart_quotes_primary('doubleLow9Reversed');
			$this->set_smart_quotes_secondary('singleLow9Reversed');
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
		
		/**
		 * Apostrophes
		 *
		 * Correctly separate apostrophes from single closing quotes.
		 */
		function process($html, $isTitle = FALSE) {
		
			// Process typography
			$processed =  parent::process($html, $isTitle);
			
			// Omnissions highlighted by an apostrophe
			$omnissions = array(
				's',	// Ist ’s recht so? 
				'n',	// Was für ’n Blödsinn!
				'ne',	// Was für ’ne tolle Idee!
				'nen'	// Hast du noch ’nen Euro?
			);
			foreach($omnissions as $omnission) {
				$processed = preg_replace('/' . $this->chr["singleQuoteOpen"] . $omnission . '\b/Uu', $this->chr["apostrophe"] . $omnission, $processed);
			}
			
			// Replace all closing quote with apostrophes
			$processed = str_replace($this->chr["singleQuoteClose"], $this->chr["apostrophe"], $processed);
			
			// Replace all apostrophes preceded by a opening single quote with a closing single quote again
			$processed = preg_replace("/(" . $this->chr["singleQuoteOpen"] . ".*[^\s|\\\\])" . $this->chr["apostrophe"] . "/Uu", '$1' . $this->chr["singleQuoteClose"], $processed);
			
			// Replace "escaped" apostrophes written as \'
			$processed = preg_replace("/\\\\" . $this->chr["apostrophe"] . "/Uu", $this->chr["apostrophe"], $processed);
			
			// Return processed string
			return $processed;
				
		}
		
		/**
		 * Smart dashes
		 *
		 * To conform to German conventions an n-dash should be used for most dashes.
		 */
		function smart_dashes($parsedHTMLtoken) {
		
			if(!isset($this->settings["smartDashes"]) || !$this->settings["smartDashes"]) return $parsedHTMLtoken;		

			// Fix dashes to confirm to German conventions
			$parsedHTMLtoken["value"] = str_replace("---", $this->chr["emDash"], $parsedHTMLtoken["value"]);
			$parsedHTMLtoken["value"] = str_replace(" -- ", " ".$this->chr["enDash"]." ", $parsedHTMLtoken["value"]);
			$parsedHTMLtoken["value"] = str_replace("--", $this->chr["enDash"], $parsedHTMLtoken["value"]);
			$parsedHTMLtoken["value"] = str_replace(" - ", " ".$this->chr["enDash"]." ", $parsedHTMLtoken["value"]);

			// Apply parent rules
			return parent::smart_dashes($parsedHTMLtoken);

		}

	}
