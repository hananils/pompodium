<?php

	Class formatterTypography extends TextFormatter {

		function about(){
			return array(
				'name' => __('Typography'),
				'version' => '1.0.1',
				'release-date' => '2010-03-30',
				'author' => array(
					'name' => 'Tony Arnold',
					'website' => 'http://www.tonyarnold.com',
					'email' => 'tony@tonyarnold.com'
				),
				'description' => 'Format entries using the PHP Typography HTML formatter.'
			);
		}

		public function run($string){

			// Apply typography
			$locale = $this->_Parent->Configuration->get('rules', 'typography');
			$typographer = EXTENSIONS . '/typography/lib/typography/' . $locale . '.typography.php';
			if(file_exists($typographer)) {
				include_once($typographer);
				$localTypography = $locale . 'Typography';
				$typography = new $localTypography(true);
				$result = $typography->process($result);
			}

			// Return formatted string
			return $result;
			
		}				
		
	}
