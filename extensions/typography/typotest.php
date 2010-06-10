<?php


	$text = <<<EOT
Um Himmels Willen, ich verstehe Jens‹ Ideen nicht und schon gar nicht Aristoteles‹.

<br /><br/>
Dies ist Nils‹ Test mit ›einfachen Anführungszeichen‹. Allerdings ist es problematisch, wenn Nils‹ Ideen vorsehen, dass parallel auch Apostrophe vorkommen. Was passiert eigentliche, wenn ›in ›nen paar Zeilen auch Jens\‹ Ideen‹ zum Tragen kommen sollen? Nimm’s hin.
<br/><br/>

Um Himmels Willen, ich verstehe Jens‹ Ideen nicht und schon gar nicht Aristoteles‹.

<br /><br/>
»Dies ist ein Test – macht der hier Typografie?« …
Ein – paar – Striche — in der Landschaft.
EOT;

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="content-type" content="application/xhtml+xml; charset=utf-8" />
		<title>Typographer Test</title>
		<style>
			
			p {
				font-family: Helvetica;
				font-size: 13px;
				line-height: 1.5;
				width: 500px;
				background: #f9f9f9;
				padding: 20px;
				margin: 50px auto;
				border: 1px solid #ccc;
			}
			
		</style>
	</head>
	<body>
		<p><?php echo $text ?></p>
		<p>
<?php 
			
	$singleQuoteOpen = '›';
	$singleQuoteClose = '‹';
	$apostrophe = '’';
	
	// Omnissions preceded by an apostrophe; \b is a word boundary
	$omnissions = array(
		
		// Ist ’s recht so?
		's\b' => 's', 
		
		// Was für ’n Blödsinn!
		'n\b' => 'n', 
		
		// Hast du noch ’nen Euro? Was für ’ne tolle Idee!
		'ne' => 'ne'
		
	);
	foreach($omnissions as $before => $after) {
		$text = str_replace($singleQuoteOpen . $before, $apostrophe . $after, $text);
	}
	
	// Replace all closing quote with apostrophes
	$text = str_replace($singleQuoteClose, $apostrophe, $text);
	
	// Replace all apostrophes preceded by a opening single quote with a closing single quote again
	$text = preg_replace("/(" . $singleQuoteOpen . ".*[^\s|\\\\])" . $apostrophe . "/Uu", '$1' . $singleQuoteClose, $text);
	
	// Replace "escaped" apostrophes written as \'
	$text = preg_replace("/\\\\" . $apostrophe . "/Uu", $apostrophe, $text);

	echo $text;

?>
		</p>
	</body>
</html>