
-- *** STRUCTURE:`tbl_fields_author` ***
DROP TABLE IF EXISTS`tbl_fields_author`;
CREATE TABLE`tbl_fields_author` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `allow_multiple_selection` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `default_to_current_user` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL,
  `author_types` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_fields_author` ***

-- *** STRUCTURE:`tbl_fields_checkbox` ***
DROP TABLE IF EXISTS`tbl_fields_checkbox`;
CREATE TABLE`tbl_fields_checkbox` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `default_state` enum('on','off') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'on',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_fields_checkbox` ***

-- *** STRUCTURE:`tbl_fields_date` ***
DROP TABLE IF EXISTS`tbl_fields_date`;
CREATE TABLE`tbl_fields_date` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `pre_populate` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_fields_date` ***

-- *** STRUCTURE:`tbl_fields_datetime` ***
DROP TABLE IF EXISTS`tbl_fields_datetime`;
CREATE TABLE`tbl_fields_datetime` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `prepopulate` tinyint(1) DEFAULT '1',
  `time` tinyint(1) DEFAULT '1',
  `multiple` tinyint(1) DEFAULT '1',
  `range` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_fields_datetime` ***
INSERT INTO`tbl_fields_datetime` (`id`, `field_id`, `prepopulate`, `time`, `multiple`, `range`) VALUES (6, 4, 1, 0, 0, 0);

-- *** STRUCTURE:`tbl_fields_input` ***
DROP TABLE IF EXISTS`tbl_fields_input`;
CREATE TABLE`tbl_fields_input` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `validator` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_fields_input` ***
INSERT INTO`tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (47, 1, NULL);
INSERT INTO`tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (28, 6, NULL);
INSERT INTO`tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (39, 9, NULL);
INSERT INTO`tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (40, 10, NULL);
INSERT INTO`tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (54, 23, NULL);
INSERT INTO`tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (53, 20, NULL);
INSERT INTO`tbl_fields_input` (`id`, `field_id`, `validator`) VALUES (41, 25, '/^[^\\s:\\/?#]+:(?:\\/{2,3})?[^\\s.\\/?#]+(?:\\.[^\\s.\\/?#]+)*(?:\\/?[^\\s?#]*\\??[^\\s?#]*(#[^\\s#]*)?)?$/');

-- *** STRUCTURE:`tbl_fields_output` ***
DROP TABLE IF EXISTS`tbl_fields_output`;
CREATE TABLE`tbl_fields_output` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `validator` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- *** DATA:`tbl_fields_output` ***
INSERT INTO`tbl_fields_output` (`id`, `field_id`, `validator`) VALUES (3, 26, '/^\\w(?:\\.?[\\w%+-]+)*@\\w(?:[\\w-]*\\.)+?[a-z]{2,}$/i');

-- *** STRUCTURE:`tbl_fields_pages` ***
DROP TABLE IF EXISTS`tbl_fields_pages`;
CREATE TABLE`tbl_fields_pages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `allow_multiple_selection` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `page_types` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_fields_pages` ***
INSERT INTO`tbl_fields_pages` (`id`, `field_id`, `allow_multiple_selection`, `page_types`) VALUES (4, 30, 'no', 'page');

-- *** STRUCTURE:`tbl_fields_select` ***
DROP TABLE IF EXISTS`tbl_fields_select`;
CREATE TABLE`tbl_fields_select` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `allow_multiple_selection` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `show_association` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'yes',
  `sort_options` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `static_options` text COLLATE utf8_unicode_ci,
  `dynamic_options` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_fields_select` ***
INSERT INTO`tbl_fields_select` (`id`, `field_id`, `allow_multiple_selection`, `show_association`, `sort_options`, `static_options`, `dynamic_options`) VALUES (22, 5, 'no', 'no', 'no', 'draft, published', NULL);
INSERT INTO`tbl_fields_select` (`id`, `field_id`, `allow_multiple_selection`, `show_association`, `sort_options`, `static_options`, `dynamic_options`) VALUES (25, 11, 'no', 'no', 'no', 'All rights reserved, CC BY, CC BY-SA, CC BY-ND, CC BY-NC, CC BY-NC-SA, CC BY-NC-ND', NULL);
INSERT INTO`tbl_fields_select` (`id`, `field_id`, `allow_multiple_selection`, `show_association`, `sort_options`, `static_options`, `dynamic_options`) VALUES (37, 29, 'no', 'no', 'no', 'draft, published', NULL);
INSERT INTO`tbl_fields_select` (`id`, `field_id`, `allow_multiple_selection`, `show_association`, `sort_options`, `static_options`, `dynamic_options`) VALUES (32, 24, 'no', 'no', 'no', 'draft, published', NULL);
INSERT INTO`tbl_fields_select` (`id`, `field_id`, `allow_multiple_selection`, `show_association`, `sort_options`, `static_options`, `dynamic_options`) VALUES (31, 27, 'yes', 'yes', 'yes', NULL, 23);

-- *** STRUCTURE:`tbl_fields_selectbox_link` ***
DROP TABLE IF EXISTS`tbl_fields_selectbox_link`;
CREATE TABLE`tbl_fields_selectbox_link` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `allow_multiple_selection` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `show_association` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'yes',
  `hide_when_prepopulated` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `related_field_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `limit` int(4) unsigned NOT NULL DEFAULT '20',
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_fields_selectbox_link` ***
INSERT INTO`tbl_fields_selectbox_link` (`id`, `field_id`, `allow_multiple_selection`, `show_association`, `hide_when_prepopulated`, `related_field_id`, `limit`) VALUES (38, 13, 'yes', 'yes', 'no', 12, 100);
INSERT INTO`tbl_fields_selectbox_link` (`id`, `field_id`, `allow_multiple_selection`, `show_association`, `hide_when_prepopulated`, `related_field_id`, `limit`) VALUES (39, 14, 'no', 'yes', 'no', 6, 100);
INSERT INTO`tbl_fields_selectbox_link` (`id`, `field_id`, `allow_multiple_selection`, `show_association`, `hide_when_prepopulated`, `related_field_id`, `limit`) VALUES (37, 5, 'no', 'yes', 'no', 12, 100);
INSERT INTO`tbl_fields_selectbox_link` (`id`, `field_id`, `allow_multiple_selection`, `show_association`, `hide_when_prepopulated`, `related_field_id`, `limit`) VALUES (42, 31, 'no', 'yes', 'no', 12, 100);

-- *** STRUCTURE:`tbl_fields_taglist` ***
DROP TABLE IF EXISTS`tbl_fields_taglist`;
CREATE TABLE`tbl_fields_taglist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `validator` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pre_populate_source` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`),
  KEY `pre_populate_source` (`pre_populate_source`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_fields_taglist` ***

-- *** STRUCTURE:`tbl_fields_textarea` ***
DROP TABLE IF EXISTS`tbl_fields_textarea`;
CREATE TABLE`tbl_fields_textarea` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `formatter` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_fields_textarea` ***
INSERT INTO`tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (54, 2, 'markdown_extra_with_smartypants', 5);
INSERT INTO`tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (55, 3, 'markdown_extra_with_smartypants', 20);
INSERT INTO`tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (28, 7, 'markdown_extra_with_smartypants', 20);
INSERT INTO`tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (68, 16, 'markdown_extra_with_smartypants', 10);
INSERT INTO`tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (67, 21, 'markdown_extra_with_smartypants', 20);
INSERT INTO`tbl_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES (66, 28, 'markdown_extra_with_smartypants', 5);

-- *** STRUCTURE:`tbl_fields_upload` ***
DROP TABLE IF EXISTS`tbl_fields_upload`;
CREATE TABLE`tbl_fields_upload` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `destination` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `validator` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_fields_upload` ***
INSERT INTO`tbl_fields_upload` (`id`, `field_id`, `destination`, `validator`) VALUES (7, 12, '/workspace/media', NULL);

-- *** STRUCTURE:`tbl_entries_data_1` ***
DROP TABLE IF EXISTS`tbl_entries_data_1`;
CREATE TABLE`tbl_entries_data_1` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_1` ***
INSERT INTO`tbl_entries_data_1` (`id`, `entry_id`, `handle`, `value`) VALUES (66, 2, 'welcome-this-is-pompodium', 'Welcome, this is Pompodium');

-- *** STRUCTURE:`tbl_entries_data_10` ***
DROP TABLE IF EXISTS`tbl_entries_data_10`;
CREATE TABLE`tbl_entries_data_10` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_10` ***

-- *** STRUCTURE:`tbl_entries_data_11` ***
DROP TABLE IF EXISTS`tbl_entries_data_11`;
CREATE TABLE`tbl_entries_data_11` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_11` ***

-- *** STRUCTURE:`tbl_entries_data_12` ***
DROP TABLE IF EXISTS`tbl_entries_data_12`;
CREATE TABLE`tbl_entries_data_12` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `file` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(11) unsigned DEFAULT NULL,
  `mimetype` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `file` (`file`),
  KEY `mimetype` (`mimetype`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_12` ***

-- *** STRUCTURE:`tbl_entries_data_13` ***
DROP TABLE IF EXISTS`tbl_entries_data_13`;
CREATE TABLE`tbl_entries_data_13` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `relation_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `relation_id` (`relation_id`)
) ENGINE=MyISAM AUTO_INCREMENT=173 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_13` ***
INSERT INTO`tbl_entries_data_13` (`id`, `entry_id`, `relation_id`) VALUES (172, 2, 0);

-- *** STRUCTURE:`tbl_entries_data_14` ***
DROP TABLE IF EXISTS`tbl_entries_data_14`;
CREATE TABLE`tbl_entries_data_14` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `relation_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `relation_id` (`relation_id`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_14` ***
INSERT INTO`tbl_entries_data_14` (`id`, `entry_id`, `relation_id`) VALUES (65, 2, 1);

-- *** STRUCTURE:`tbl_entries_data_16` ***
DROP TABLE IF EXISTS`tbl_entries_data_16`;
CREATE TABLE`tbl_entries_data_16` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` mediumtext COLLATE utf8_unicode_ci,
  `value_formatted` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_16` ***
INSERT INTO`tbl_entries_data_16` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (12, 32, 'Cras mattis consectetur purus sit amet fermentum. Etiam porta sem malesuada magna mollis euismod. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Curabitur blandit tempus porttitor. ', '<p>Cras mattis consectetur purus sit amet fermentum. Etiam porta sem malesuada magna mollis euismod. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Curabitur blandit tempus porttitor.</p>\n');

-- *** STRUCTURE:`tbl_entries_data_2` ***
DROP TABLE IF EXISTS`tbl_entries_data_2`;
CREATE TABLE`tbl_entries_data_2` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` mediumtext COLLATE utf8_unicode_ci,
  `value_formatted` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_2` ***
INSERT INTO`tbl_entries_data_2` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (65, 2, 'Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Sed posuere consectetur est at lobortis. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Donec sed odio dui. Cras mattis consectetur purus sit amet fermentum. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.', '<p>Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Sed posuere consectetur est at lobortis. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Donec sed odio dui. Cras mattis consectetur purus sit amet fermentum. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.</p>\n');

-- *** STRUCTURE:`tbl_entries_data_20` ***
DROP TABLE IF EXISTS`tbl_entries_data_20`;
CREATE TABLE`tbl_entries_data_20` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_20` ***
INSERT INTO`tbl_entries_data_20` (`id`, `entry_id`, `handle`, `value`) VALUES (42, 6, 'about-this-site', 'About this site');

-- *** STRUCTURE:`tbl_entries_data_21` ***
DROP TABLE IF EXISTS`tbl_entries_data_21`;
CREATE TABLE`tbl_entries_data_21` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` mediumtext COLLATE utf8_unicode_ci,
  `value_formatted` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_21` ***
INSERT INTO`tbl_entries_data_21` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (42, 6, 'Etiam porta sem malesuada magna mollis euismod. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Maecenas faucibus mollis interdum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.\r\n\r\nMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras justo odio, dapibus ac facilisis in, egestas eget quam.\r\n\r\nAenean lacinia bibendum nulla sed consectetur. Aenean lacinia bibendum nulla sed consectetur. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Maecenas faucibus mollis interdum. Donec ullamcorper nulla non metus auctor fringilla.\r\n\r\nMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Nullam id dolor id nibh ultricies vehicula ut id elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Cras justo odio, dapibus ac facilisis in, egestas eget quam.', '<p>Etiam porta sem malesuada magna mollis euismod. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Maecenas faucibus mollis interdum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.</p>\n\n<p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras justo odio, dapibus ac facilisis in, egestas eget quam.</p>\n\n<p>Aenean lacinia bibendum nulla sed consectetur. Aenean lacinia bibendum nulla sed consectetur. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Maecenas faucibus mollis interdum. Donec ullamcorper nulla non metus auctor fringilla.</p>\n\n<p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Nullam id dolor id nibh ultricies vehicula ut id elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Cras justo odio, dapibus ac facilisis in, egestas eget quam.</p>\n');

-- *** STRUCTURE:`tbl_entries_data_23` ***
DROP TABLE IF EXISTS`tbl_entries_data_23`;
CREATE TABLE`tbl_entries_data_23` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_23` ***
INSERT INTO`tbl_entries_data_23` (`id`, `entry_id`, `handle`, `value`) VALUES (11, 32, 'sam-symphonist', 'Sam Symphonist');

-- *** STRUCTURE:`tbl_entries_data_24` ***
DROP TABLE IF EXISTS`tbl_entries_data_24`;
CREATE TABLE`tbl_entries_data_24` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_24` ***
INSERT INTO`tbl_entries_data_24` (`id`, `entry_id`, `handle`, `value`) VALUES (43, 2, 'published', 'published');

-- *** STRUCTURE:`tbl_entries_data_25` ***
DROP TABLE IF EXISTS`tbl_entries_data_25`;
CREATE TABLE`tbl_entries_data_25` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_25` ***

-- *** STRUCTURE:`tbl_entries_data_26` ***
DROP TABLE IF EXISTS`tbl_entries_data_26`;
CREATE TABLE`tbl_entries_data_26` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_26` ***
INSERT INTO`tbl_entries_data_26` (`id`, `entry_id`, `handle`, `value`) VALUES (10, 32, 'sam-examplecom', 'sam@example.com');

-- *** STRUCTURE:`tbl_entries_data_27` ***
DROP TABLE IF EXISTS`tbl_entries_data_27`;
CREATE TABLE`tbl_entries_data_27` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_27` ***
INSERT INTO`tbl_entries_data_27` (`id`, `entry_id`, `handle`, `value`) VALUES (57, 2, 'sam-symphonist', 'Sam Symphonist');

-- *** STRUCTURE:`tbl_entries_data_28` ***
DROP TABLE IF EXISTS`tbl_entries_data_28`;
CREATE TABLE`tbl_entries_data_28` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` mediumtext COLLATE utf8_unicode_ci,
  `value_formatted` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_28` ***
INSERT INTO`tbl_entries_data_28` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (38, 6, 'Nullam id dolor id nibh ultricies vehicula ut id elit. Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Aenean lacinia bibendum nulla sed consectetur. Sed posuere consectetur est at lobortis.', '<p>Nullam id dolor id nibh ultricies vehicula ut id elit. Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Aenean lacinia bibendum nulla sed consectetur. Sed posuere consectetur est at lobortis.</p>\n');

-- *** STRUCTURE:`tbl_entries_data_29` ***
DROP TABLE IF EXISTS`tbl_entries_data_29`;
CREATE TABLE`tbl_entries_data_29` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_29` ***
INSERT INTO`tbl_entries_data_29` (`id`, `entry_id`, `handle`, `value`) VALUES (38, 6, 'published', 'published');

-- *** STRUCTURE:`tbl_entries_data_3` ***
DROP TABLE IF EXISTS`tbl_entries_data_3`;
CREATE TABLE`tbl_entries_data_3` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` mediumtext COLLATE utf8_unicode_ci,
  `value_formatted` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_3` ***
INSERT INTO`tbl_entries_data_3` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (65, 2, 'Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.\r\n\r\nDonec id elit non mi porta gravida at eget metus. Donec ullamcorper nulla non metus auctor fringilla. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum id ligula porta felis euismod semper. Lorem ipsum dolor sit amet, consectetur adipiscing elit.\r\n\r\nPraesent commodo cursus magna, vel scelerisque nisl consectetur et. Curabitur blandit tempus porttitor. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Nullam id dolor id nibh ultricies vehicula ut id elit.\r\n\r\nCurabitur blandit tempus porttitor. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Nullam id dolor id nibh ultricies vehicula ut id elit. Maecenas faucibus mollis interdum.', '<p>Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n\n<p>Donec id elit non mi porta gravida at eget metus. Donec ullamcorper nulla non metus auctor fringilla. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum id ligula porta felis euismod semper. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>\n\n<p>Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Curabitur blandit tempus porttitor. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>\n\n<p>Curabitur blandit tempus porttitor. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Nullam id dolor id nibh ultricies vehicula ut id elit. Maecenas faucibus mollis interdum.</p>\n');

-- *** STRUCTURE:`tbl_entries_data_30` ***
DROP TABLE IF EXISTS`tbl_entries_data_30`;
CREATE TABLE`tbl_entries_data_30` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `page_id` (`page_id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_30` ***
INSERT INTO`tbl_entries_data_30` (`id`, `entry_id`, `page_id`, `title`, `handle`) VALUES (38, 6, 2, 'about', 'about');

-- *** STRUCTURE:`tbl_entries_data_31` ***
DROP TABLE IF EXISTS`tbl_entries_data_31`;
CREATE TABLE`tbl_entries_data_31` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `relation_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `relation_id` (`relation_id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_31` ***
INSERT INTO`tbl_entries_data_31` (`id`, `entry_id`, `relation_id`) VALUES (35, 6, 31);

-- *** STRUCTURE:`tbl_entries_data_4` ***
DROP TABLE IF EXISTS`tbl_entries_data_4`;
CREATE TABLE`tbl_entries_data_4` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_4` ***
INSERT INTO`tbl_entries_data_4` (`id`, `entry_id`, `start`, `end`) VALUES (52, 2, '2013-08-12 14:19:28', '2013-08-12 14:19:28');

-- *** STRUCTURE:`tbl_entries_data_5` ***
DROP TABLE IF EXISTS`tbl_entries_data_5`;
CREATE TABLE`tbl_entries_data_5` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `relation_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `relation_id` (`relation_id`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_5` ***
INSERT INTO`tbl_entries_data_5` (`id`, `entry_id`, `relation_id`) VALUES (53, 2, 0);

-- *** STRUCTURE:`tbl_entries_data_6` ***
DROP TABLE IF EXISTS`tbl_entries_data_6`;
CREATE TABLE`tbl_entries_data_6` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_6` ***
INSERT INTO`tbl_entries_data_6` (`id`, `entry_id`, `handle`, `value`) VALUES (1, 1, 'symphony', 'Symphony');

-- *** STRUCTURE:`tbl_entries_data_7` ***
DROP TABLE IF EXISTS`tbl_entries_data_7`;
CREATE TABLE`tbl_entries_data_7` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` mediumtext COLLATE utf8_unicode_ci,
  `value_formatted` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_7` ***
INSERT INTO`tbl_entries_data_7` (`id`, `entry_id`, `value`, `value_formatted`) VALUES (1, 1, 'This category is about Symphony.', '<p>This category is about Symphony.</p>\n');

-- *** STRUCTURE:`tbl_entries_data_9` ***
DROP TABLE IF EXISTS`tbl_entries_data_9`;
CREATE TABLE`tbl_entries_data_9` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- *** DATA:`tbl_entries_data_9` ***

-- *** DATA:`tbl_documentation` ***
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (1, 'Articles', '/publish/articles/', 'Edit existing articles or create a new one.', '<p>Edit existing articles or create a new one.</p>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (2, 'Create new article', '/publish/articles/new/', '1. Enter title\r\n2. Select Cover Image and Media\r\n3. Enter Introduction and Body text\r\n4. Select Author, Date, Category and Status\r\n5. Create entry\r\n\r\n### Cover Image and Media\r\n\r\nUpload your cover image and media in [Meta - Media](/symphony/publish/media/).\r\n\r\nSelect all media you would like to attach to your article in the Media select box. Selected images will be automatically displayed below the body text on your website, unless you include them in your text using the following shortcut, separated by blank lines:\r\n\r\n    image: example.jpg\r\n\r\n### Authors\r\n\r\nEdit your author list in [Meta - Authors](/symphony/publish/authors/).\r\n\r\n### Categories\r\n\r\nEdit your category list in [Meta - Categories](/symphony/publish/categories/).', '<ol>\n<li>Enter title</li>\n<li>Select Cover Image and Media</li>\n<li>Enter Introduction and Body text</li>\n<li>Select Author, Date, Category and Status</li>\n<li>Create entry</li>\n</ol>\n\n<h3>Cover Image and Media</h3>\n\n<p>Upload your cover image and media in <a href=\"/symphony/publish/media/\">Meta - Media</a>.</p>\n\n<p>Select all media you would like to attach to your article in the Media select box. Selected images will be automatically displayed below the body text on your website, unless you include them in your text using the following shortcut, separated by blank lines:</p>\n\n<pre><code>image: example.jpg\n</code></pre>\n\n<h3>Authors</h3>\n\n<p>Edit your author list in <a href=\"/symphony/publish/authors/\">Meta - Authors</a>.</p>\n\n<h3>Categories</h3>\n\n<p>Edit your category list in <a href=\"/symphony/publish/categories/\">Meta - Categories</a>.</p>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (3, 'Text formatting', '/publish/articles/new/,/publish/articles/edit/,/publish/pages/new/,/publish/pages/edit/,/publish/authors/new/,/publish/authors/edit/', 'Seperate block elements by blank lines (paragraphs, headers, lists etc.)\r\n\r\n### Paragraphs, Line Breaks, Headers\r\n\r\nParagraphs are seperated by blank lines\r\n\r\nLine breaks`  `  \r\nare indicated by two spaces`  `  \r\nat the end of the line\r\n\r\n`# headers` are indicated by hash characters at the start of the line\r\n\r\n### Emphasis\r\n\r\n`*Emphasize*` with single asterisks\r\n\r\n`**Strongly**` emphasize with double asterisks\r\n\r\n### Lists\r\n\r\n`\\- `Use hyphens  \r\n`\\- `to indicate  \r\n`\\- `an unordered list\r\n\r\n`\\1. `Use numbers followed by periods  \r\n`\\2. `to indicate  \r\n`\\3. `an ordered list\r\n\r\n### Links\r\n\r\n`[example site](http://example.com)`\r\n\r\nShort hand for displaying linked URLs or email addresses:\r\n\r\n`<http://example.com>`\r\n\r\n`<info@example.com>`\r\n\r\n### Further help\r\n\r\nCheck out the [complete documentation of Markdown\'s syntax](http://daringfireball.net/projects/markdown/syntax) for answers to all your formatting needs.', '<p>Seperate block elements by blank lines (paragraphs, headers, lists etc.)</p>\n\n<h3>Paragraphs, Line Breaks, Headers</h3>\n\n<p>Paragraphs are seperated by blank lines</p>\n\n<p>Line breaks<code></code><br />\nare indicated by two spaces<code></code><br />\nat the end of the line</p>\n\n<p><code># headers</code> are indicated by hash characters at the start of the line</p>\n\n<h3>Emphasis</h3>\n\n<p><code>*Emphasize*</code> with single asterisks</p>\n\n<p><code>**Strongly**</code> emphasize with double asterisks</p>\n\n<h3>Lists</h3>\n\n<p><code>-</code>Use hyphens<br />\n<code>-</code>to indicate<br />\n<code>-</code>an unordered list</p>\n\n<p><code>1.</code>Use numbers followed by periods<br />\n<code>2.</code>to indicate<br />\n<code>3.</code>an ordered list</p>\n\n<h3>Links</h3>\n\n<p><code>[example site](http://example.com)</code></p>\n\n<p>Short hand for displaying linked URLs or email addresses:</p>\n\n<p><code>&lt;http://example.com&gt;</code></p>\n\n<p><code>&lt;info@example.com&gt;</code></p>\n\n<h3>Further help</h3>\n\n<p>Check out the <a href=\"http://daringfireball.net/projects/markdown/syntax\">complete documentation of Markdown&#8217;s syntax</a> for answers to all your formatting needs.</p>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (4, 'Edit article', '/publish/articles/edit/', '1. Edit information\r\n2. Save changes\r\n\r\n### Cover Image and Media\r\n\r\nUpload your cover image and media in [Meta - Media](/symphony/publish/media/).\r\n\r\nSelect all media you would like to attach to your article in the `Media` select box. Selected images will be automatically displayed below the body text on your website, unless you include them in your text using the following shortcut, separated by blank lines:\r\n\r\n    image: example.jpg\r\n\r\n### Authors\r\n\r\nEdit your author list in [Meta - Authors](/symphony/publish/authors/).\r\n\r\n### Categories\r\n\r\nEdit your category list in [Meta - Categories](/symphony/publish/categories/).', '<ol>\n<li>Edit information</li>\n<li>Save changes</li>\n</ol>\n\n<h3>Cover Image and Media</h3>\n\n<p>Upload your cover image and media in <a href=\"/symphony/publish/media/\">Meta - Media</a>.</p>\n\n<p>Select all media you would like to attach to your article in the <code>Media</code> select box. Selected images will be automatically displayed below the body text on your website, unless you include them in your text using the following shortcut, separated by blank lines:</p>\n\n<pre><code>image: example.jpg\n</code></pre>\n\n<h3>Authors</h3>\n\n<p>Edit your author list in <a href=\"/symphony/publish/authors/\">Meta - Authors</a>.</p>\n\n<h3>Categories</h3>\n\n<p>Edit your category list in <a href=\"/symphony/publish/categories/\">Meta - Categories</a>.</p>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (5, 'Pages', '/publish/pages/', 'Edit or add content to existing Symphony pages.\r\n\r\n### Create new Symphony page\r\n\r\nContent can be added to all existing Symphony pages of the type `page`. Developers can edit pages in [Blueprints - Pages](/symphony/blueprints/pages/). To add content to a new page, take the [about page](/symphony/blueprints/pages/edit/2/) page as an example and follow these steps:\r\n\r\n1. [Create new page](/symphony/blueprints/pages/new/) in [Blueprints - Pages](/symphony/blueprints/pages/)\r\n2. Add page type `page` and attach data sources as seen on [about page](/symphony/blueprints/pages/edit/2/)\r\n3. Import templates as seen in [about.xsl](/symphony/blueprints/pages/template/about/)\r\n4. [Create new page content](/symphony/publish/pages/new/)\r\n5. Select new Symphony page in the Pages select box\r\n6. Done!', '<p>Edit or add content to existing Symphony pages.</p>\n\n<h3>Create new Symphony page</h3>\n\n<p>Content can be added to all existing Symphony pages of the type <code>page</code>. Developers can edit pages in <a href=\"/symphony/blueprints/pages/\">Blueprints - Pages</a>. To add content to a new page, take the <a href=\"/symphony/blueprints/pages/edit/2/\">about page</a> page as an example and follow these steps:</p>\n\n<ol>\n<li><a href=\"/symphony/blueprints/pages/new/\">Create new page</a> in <a href=\"/symphony/blueprints/pages/\">Blueprints - Pages</a></li>\n<li>Add page type <code>page</code> and attach data sources as seen on <a href=\"/symphony/blueprints/pages/edit/2/\">about page</a></li>\n<li>Import templates as seen in <a href=\"/symphony/blueprints/pages/template/about/\">about.xsl</a></li>\n<li><a href=\"/symphony/publish/pages/new/\">Create new page content</a></li>\n<li>Select new Symphony page in the Pages select box</li>\n<li>Done!</li>\n</ol>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (6, 'Edit page', '/publish/pages/edit/', '1. Edit information\r\n5. Save changes\r\n\r\n### Cover Image\r\n\r\nUpload your cover image under [Meta - Media](/symphony/publish/media/).\r\n\r\n### Create new Symphony page\r\n\r\nContent can be added to all existing Symphony pages of the type `page`. Developers can edit pages in [Blueprints - Pages](/symphony/blueprints/pages/). To add content to a new page, take the [About page](/symphony/blueprints/pages/edit/2/) page as an example and follow these steps:\r\n\r\n1. [Create new page](/symphony/blueprints/pages/new/) in [Blueprints - Pages](/symphony/blueprints/pages/)\r\n2. Add page type `page` and attach data sources as seen on [about page](/symphony/blueprints/pages/edit/2/)\r\n3. Import templates as seen in [about.xsl](/symphony/blueprints/pages/template/about/)\r\n4. [Create new page content](/symphony/publish/pages/new/)\r\n5. Select new Symphony page in the Pages select box\r\n6. Done!', '<ol>\n<li>Edit information</li>\n<li>Save changes</li>\n</ol>\n\n<h3>Cover Image</h3>\n\n<p>Upload your cover image under <a href=\"/symphony/publish/media/\">Meta - Media</a>.</p>\n\n<h3>Create new Symphony page</h3>\n\n<p>Content can be added to all existing Symphony pages of the type <code>page</code>. Developers can edit pages in <a href=\"/symphony/blueprints/pages/\">Blueprints - Pages</a>. To add content to a new page, take the <a href=\"/symphony/blueprints/pages/edit/2/\">About page</a> page as an example and follow these steps:</p>\n\n<ol>\n<li><a href=\"/symphony/blueprints/pages/new/\">Create new page</a> in <a href=\"/symphony/blueprints/pages/\">Blueprints - Pages</a></li>\n<li>Add page type <code>page</code> and attach data sources as seen on <a href=\"/symphony/blueprints/pages/edit/2/\">about page</a></li>\n<li>Import templates as seen in <a href=\"/symphony/blueprints/pages/template/about/\">about.xsl</a></li>\n<li><a href=\"/symphony/publish/pages/new/\">Create new page content</a></li>\n<li>Select new Symphony page in the Pages select box</li>\n<li>Done!</li>\n</ol>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (7, 'Create new page', '/publish/pages/new/', '1. Enter title\r\n2. Select Cover Image\r\n3. Enter Introduction and Body text\r\n4. Select Page and Status\r\n5. Create entry\r\n\r\n### Cover Image\r\n\r\nUpload your cover image under [Meta - Media](/symphony/publish/media/).\r\n\r\n### Create new Symphony page\r\n\r\nContent can be added to all existing Symphony pages of the type `page`. Developers can edit pages in [Blueprints - Pages](/symphony/blueprints/pages/). To add content to a new page, take the [About page](/symphony/blueprints/pages/edit/2/) page as an example and follow these steps:\r\n\r\n1. [Create new page](/symphony/blueprints/pages/new/) in [Blueprints - Pages](/symphony/blueprints/pages/)\r\n2. Add page type `page` and attach data sources as seen on [about page](/symphony/blueprints/pages/edit/2/)\r\n3. Import templates as seen in [about.xsl](/symphony/blueprints/pages/template/about/)\r\n4. [Create new page content](/symphony/publish/pages/new/)\r\n5. Select new Symphony page in the Pages select box\r\n6. Done!', '<ol>\n<li>Enter title</li>\n<li>Select Cover Image</li>\n<li>Enter Introduction and Body text</li>\n<li>Select Page and Status</li>\n<li>Create entry</li>\n</ol>\n\n<h3>Cover Image</h3>\n\n<p>Upload your cover image under <a href=\"/symphony/publish/media/\">Meta - Media</a>.</p>\n\n<h3>Create new Symphony page</h3>\n\n<p>Content can be added to all existing Symphony pages of the type <code>page</code>. Developers can edit pages in <a href=\"/symphony/blueprints/pages/\">Blueprints - Pages</a>. To add content to a new page, take the <a href=\"/symphony/blueprints/pages/edit/2/\">About page</a> page as an example and follow these steps:</p>\n\n<ol>\n<li><a href=\"/symphony/blueprints/pages/new/\">Create new page</a> in <a href=\"/symphony/blueprints/pages/\">Blueprints - Pages</a></li>\n<li>Add page type <code>page</code> and attach data sources as seen on <a href=\"/symphony/blueprints/pages/edit/2/\">about page</a></li>\n<li>Import templates as seen in <a href=\"/symphony/blueprints/pages/template/about/\">about.xsl</a></li>\n<li><a href=\"/symphony/publish/pages/new/\">Create new page content</a></li>\n<li>Select new Symphony page in the Pages select box</li>\n<li>Done!</li>\n</ol>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (8, 'Categories', '/publish/categories/', 'Edit existing categories or create a new one.', '<p>Edit existing categories or create a new one.</p>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (9, 'Edit category', '/publish/categories/edit/', '1. Edit information\r\n2. Save changes', '<ol>\n<li>Edit information</li>\n<li>Save changes</li>\n</ol>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (10, 'Create new category', '/publish/categories/new/', '1. Enter name and description\r\n2. Create entry', '<ol>\n<li>Enter name and description</li>\n<li>Create entry</li>\n</ol>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (11, 'Authors', '/publish/authors/', 'Edit existing authors or create a new one.', '<p>Edit existing authors or create a new one.</p>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (12, 'Edit author', '/publish/authors/edit/', '1. Edit information\r\n2. Save changes', '<ol>\n<li>Edit information</li>\n<li>Save changes</li>\n</ol>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (13, 'Create new author', '/publish/authors/new/', '1. Enter name, email and about text\r\n2. Create entry', '<ol>\n<li>Enter name, email and about text</li>\n<li>Create entry</li>\n</ol>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (14, 'Media', '/publish/media/', 'Edit existing or upload new media.', '<p>Edit existing or upload new media.</p>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (15, 'Edit media', '/publish/media/edit/', '1. Edit information\r\n2. Save changes', '<ol>\n<li>Edit information</li>\n<li>Save changes</li>\n</ol>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (16, 'Create new media', '/publish/media/new/', '1. Enter title\r\n2. Enter author and link\r\n3. Upload file\r\n4. Select licence\r\n5. Create entry\r\n', '<ol>\n<li>Enter title</li>\n<li>Enter author and link</li>\n<li>Upload file</li>\n<li>Select licence</li>\n<li>Create entry</li>\n</ol>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (17, 'Symphony Pages', '/blueprints/pages/', 'Edit existing or create new Symphony pages.\r\n\r\n### Add content to a Symphony page\r\n\r\nContent can be added to all existing Symphony pages of the type `page`. Authors and developers can edit and create page content in [Content - Pages](/symphony/publish/pages/). To add content to a new page, take the [about page](/symphony/blueprints/pages/edit/2/) page as an example and follow these steps:\r\n\r\n1. [Create new page](/symphony/blueprints/pages/new/)\r\n2. Add page type `page` and attach data sources as seen on [about page](/symphony/blueprints/pages/edit/2/)\r\n3. Import templates as seen in [about.xsl](/symphony/blueprints/pages/template/about/)\r\n4. [Create new page content](/symphony/publish/pages/new/)\r\n5. Select new Symphony page in the Pages select box\r\n6. Done!', '<p>Edit existing or create new Symphony pages.</p>\n\n<h3>Add content to a Symphony page</h3>\n\n<p>Content can be added to all existing Symphony pages of the type <code>page</code>. Authors and developers can edit and create page content in <a href=\"/symphony/publish/pages/\">Content - Pages</a>. To add content to a new page, take the <a href=\"/symphony/blueprints/pages/edit/2/\">about page</a> page as an example and follow these steps:</p>\n\n<ol>\n<li><a href=\"/symphony/blueprints/pages/new/\">Create new page</a></li>\n<li>Add page type <code>page</code> and attach data sources as seen on <a href=\"/symphony/blueprints/pages/edit/2/\">about page</a></li>\n<li>Import templates as seen in <a href=\"/symphony/blueprints/pages/template/about/\">about.xsl</a></li>\n<li><a href=\"/symphony/publish/pages/new/\">Create new page content</a></li>\n<li>Select new Symphony page in the Pages select box</li>\n<li>Done!</li>\n</ol>\n');
INSERT INTO`tbl_documentation` (`id`, `title`, `pages`, `content`, `content_formatted`) VALUES (18, 'Create new page', '/blueprints/pages/new/', '### Add content to a Symphony page\r\n\r\nContent can be added to all existing Symphony pages of the type `page`. Authors and developers can edit and create page content in [Content - Pages](/symphony/publish/pages/). To add content to a new page, take the [about page](/symphony/blueprints/pages/edit/2/) page as an example and follow these steps:\r\n\r\n1. [Create new page](/symphony/blueprints/pages/new/)\r\n2. Add page type `page` and attach data sources as seen on [about page](/symphony/blueprints/pages/edit/2/)\r\n3. Import templates as seen in [about.xsl](/symphony/blueprints/pages/template/about/)\r\n4. [Create new page content](/symphony/publish/pages/new/)\r\n5. Select new Symphony page in the Pages select box\r\n6. Done!', '<h3>Add content to a Symphony page</h3>\n\n<p>Content can be added to all existing Symphony pages of the type <code>page</code>. Authors and developers can edit and create page content in <a href=\"/symphony/publish/pages/\">Content - Pages</a>. To add content to a new page, take the <a href=\"/symphony/blueprints/pages/edit/2/\">about page</a> page as an example and follow these steps:</p>\n\n<ol>\n<li><a href=\"/symphony/blueprints/pages/new/\">Create new page</a></li>\n<li>Add page type <code>page</code> and attach data sources as seen on <a href=\"/symphony/blueprints/pages/edit/2/\">about page</a></li>\n<li>Import templates as seen in <a href=\"/symphony/blueprints/pages/template/about/\">about.xsl</a></li>\n<li><a href=\"/symphony/publish/pages/new/\">Create new page content</a></li>\n<li>Select new Symphony page in the Pages select box</li>\n<li>Done!</li>\n</ol>\n');

-- *** DATA:`tbl_entries` ***
INSERT INTO`tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`, `modification_date`, `modification_date_gmt`) VALUES (1, 4, 1, '2013-08-12 12:26:14', '2013-08-12 10:26:14', '2013-08-12 12:26:14', '2013-08-12 10:26:14');
INSERT INTO`tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`, `modification_date`, `modification_date_gmt`) VALUES (2, 1, 1, '2013-08-12 12:44:52', '2013-08-12 10:44:52', '2013-08-15 14:19:28', '2013-08-15 12:19:28');
INSERT INTO`tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`, `modification_date`, `modification_date_gmt`) VALUES (6, 5, 1, '2013-08-12 13:27:01', '2013-08-12 11:27:01', '2013-08-15 14:18:39', '2013-08-15 12:18:39');
INSERT INTO`tbl_entries` (`id`, `section_id`, `author_id`, `creation_date`, `creation_date_gmt`, `modification_date`, `modification_date_gmt`) VALUES (32, 3, 1, '2013-08-15 14:19:12', '2013-08-15 12:19:12', '2013-08-15 14:19:49', '2013-08-15 12:19:49');

-- *** DATA:`tbl_extensions` ***
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (1, 'debugdevkit', 'enabled', '1.2.4');
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (2, 'export_ensemble', 'enabled', '2.0.3');
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (3, 'jit_image_manipulation', 'enabled', 1.19);
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (4, 'maintenance_mode', 'enabled', 1.7);
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (5, 'markdown', 'enabled', 1.17);
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (6, 'profiledevkit', 'enabled', 1.3);
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (7, 'selectbox_link_field', 'enabled', 1.28);
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (8, 'xssfilter', 'enabled', 1.2);
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (10, 'datetime', 'enabled', '3.1.1');
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (11, 'html5_doctype', 'enabled', '1.3.1');
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (12, 'output_field', 'enabled', 2.0);
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (13, 'pagesfield', 'enabled', 1.5);
INSERT INTO`tbl_extensions` (`id`, `name`, `status`, `version`) VALUES (14, 'documenter', 'enabled', '2.1.2');

-- *** DATA:`tbl_extensions_delegates` ***
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (1, 1, '/frontend/', 'FrontendDevKitResolve', 'frontendDevKitResolve');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (2, 1, '/frontend/', 'ManipulateDevKitNavigation', 'manipulateDevKitNavigation');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (3, 2, '/system/preferences/', 'AddCustomPreferenceFieldsets', 'appendPreferences');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (4, 3, '/system/preferences/', 'AddCustomPreferenceFieldsets', 'appendPreferences');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (5, 3, '/system/preferences/', 'Save', '__SavePreferences');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (6, 4, '/system/preferences/', 'AddCustomPreferenceFieldsets', 'appendPreferences');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (7, 4, '/system/preferences/', 'Save', '__SavePreferences');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (8, 4, '/system/preferences/', 'CustomActions', '__toggleMaintenanceMode');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (9, 4, '/backend/', 'AppendPageAlert', '__appendAlert');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (10, 4, '/blueprints/pages/', 'AppendPageContent', '__appendType');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (11, 4, '/frontend/', 'FrontendPrePageResolve', '__checkForMaintenanceMode');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (12, 4, '/frontend/', 'FrontendParamsResolve', '__addParam');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (13, 6, '/frontend/', 'FrontendDevKitResolve', 'frontendDevKitResolve');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (14, 6, '/frontend/', 'ManipulateDevKitNavigation', 'manipulateDevKitNavigation');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (15, 8, '/blueprints/events/new/', 'AppendEventFilter', 'appendEventFilter');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (16, 8, '/blueprints/events/edit/', 'AppendEventFilter', 'appendEventFilter');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (17, 8, '/frontend/', 'EventPreSaveFilter', 'eventPreSaveFilter');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (22, 10, '/system/preferences/', 'Save', '__savePreferences');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (21, 10, '/system/preferences/', 'AddCustomPreferenceFieldsets', '__addPreferences');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (23, 11, '/frontend/', 'FrontendOutputPostGenerate', 'parse_html');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (24, 11, '/frontend/', 'FrontendPageResolved', 'setRenderTrigger');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (25, 11, '/system/preferences/', 'AddCustomPreferenceFieldsets', 'appendPreferences');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (32, 14, '/backend/', 'InitaliseAdminPageHead', 'loadAssets');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (31, 14, '/system/preferences/', 'Save', '__SavePreferences');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (30, 14, '/system/preferences/', 'AddCustomPreferenceFieldsets', 'appendPreferences');
INSERT INTO`tbl_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES (33, 14, '/backend/', 'InitaliseAdminPageHead', 'appendDocs');

-- *** DATA:`tbl_fields` ***
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (1, 'Title', 'title', 'input', 1, 'yes', 0, 'main', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (2, 'Introduction', 'introduction', 'textarea', 1, 'no', 3, 'main', 'no');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (3, 'Body', 'body', 'textarea', 1, 'no', 4, 'main', 'no');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (4, 'Date', 'date', 'datetime', 1, 'yes', 6, 'sidebar', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (5, 'Cover Image', 'cover-image', 'selectbox_link', 1, 'no', 1, 'main', 'no');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (6, 'Name', 'name', 'input', 4, 'yes', 0, 'main', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (7, 'Description', 'description', 'textarea', 4, 'no', 1, 'main', 'no');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (14, 'Category', 'category', 'selectbox_link', 1, 'yes', 7, 'sidebar', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (9, 'Title', 'title', 'input', 2, 'no', 0, 'main', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (10, 'Author', 'author', 'input', 2, 'no', 1, 'main', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (11, 'Licence', 'licence', 'select', 2, 'no', 4, 'sidebar', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (12, 'File', 'file', 'upload', 2, 'no', 3, 'main', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (13, 'Media', 'media', 'selectbox_link', 1, 'no', 2, 'main', 'no');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (23, 'Name', 'name', 'input', 3, 'yes', 0, 'main', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (16, 'About', 'about', 'textarea', 3, 'no', 2, 'main', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (27, 'Author', 'author', 'select', 1, 'yes', 5, 'sidebar', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (20, 'Title', 'title', 'input', 5, 'no', 0, 'main', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (21, 'Body', 'body', 'textarea', 5, 'no', 3, 'main', 'no');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (28, 'Introduction', 'introduction', 'textarea', 5, 'no', 2, 'main', 'no');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (24, 'Status', 'status', 'select', 1, 'yes', 8, 'sidebar', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (25, 'Link', 'link', 'input', 2, 'no', 2, 'main', 'no');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (26, 'Email', 'email', 'output', 3, 'no', 1, 'main', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (29, 'Status', 'status', 'select', 5, 'no', 5, 'sidebar', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (30, 'Page', 'page', 'pages', 5, 'yes', 4, 'sidebar', 'yes');
INSERT INTO`tbl_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES (31, 'Cover image', 'cover-image', 'selectbox_link', 5, 'no', 1, 'main', 'yes');

-- *** DATA:`tbl_pages` ***
INSERT INTO`tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (1, NULL, 'articles', 'articles', NULL, 'title', 'articles_current,articles_media,articles_overview,authors,datetime,navigation', NULL, 2);
INSERT INTO`tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (2, NULL, 'about', 'about', NULL, NULL, 'articles_current,articles_media,articles_overview,authors,datetime,navigation,pages', NULL, 6);
INSERT INTO`tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (3, NULL, 'feed', 'feed', NULL, NULL, 'navigation,articles_media,articles_overview,authors', NULL, 8);
INSERT INTO`tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (4, NULL, 'page not found', 404, NULL, NULL, 'navigation', NULL, 9);
INSERT INTO`tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (5, NULL, 'forbidden', 403, NULL, NULL, 'navigation', NULL, 10);
INSERT INTO`tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (6, NULL, 'maintenance', 'maintenance', NULL, NULL, 'navigation', NULL, 10);
INSERT INTO`tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (7, 1, 'category', 'category', 'articles', 'category', 'articles_current,articles_media,articles_overview,authors,datetime,navigation', NULL, 3);
INSERT INTO`tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (8, 1, 'date', 'date', 'articles', 'year/month', 'articles_current,articles_media,articles_overview,authors,datetime,navigation', NULL, 5);
INSERT INTO`tbl_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES (9, 1, 'author', 'author', 'articles', 'author', 'articles_current,articles_media,articles_overview,authors,datetime,navigation', NULL, 4);

-- *** DATA:`tbl_pages_types` ***
INSERT INTO`tbl_pages_types` (`id`, `page_id`, `type`) VALUES (14, 4, 404);
INSERT INTO`tbl_pages_types` (`id`, `page_id`, `type`) VALUES (15, 5, 403);
INSERT INTO`tbl_pages_types` (`id`, `page_id`, `type`) VALUES (16, 3, 'navigation');
INSERT INTO`tbl_pages_types` (`id`, `page_id`, `type`) VALUES (34, 1, 'navigation');
INSERT INTO`tbl_pages_types` (`id`, `page_id`, `type`) VALUES (17, 3, 'XML');
INSERT INTO`tbl_pages_types` (`id`, `page_id`, `type`) VALUES (19, 6, 'maintenance');
INSERT INTO`tbl_pages_types` (`id`, `page_id`, `type`) VALUES (35, 2, 'about');
INSERT INTO`tbl_pages_types` (`id`, `page_id`, `type`) VALUES (33, 1, 'index');
INSERT INTO`tbl_pages_types` (`id`, `page_id`, `type`) VALUES (36, 2, 'navigation');
INSERT INTO`tbl_pages_types` (`id`, `page_id`, `type`) VALUES (37, 2, 'page');

-- *** DATA:`tbl_sections` ***
INSERT INTO`tbl_sections` (`id`, `name`, `handle`, `sortorder`, `hidden`, `navigation_group`) VALUES (1, 'Articles', 'articles', 1, 'no', 'Content');
INSERT INTO`tbl_sections` (`id`, `name`, `handle`, `sortorder`, `hidden`, `navigation_group`) VALUES (2, 'Media', 'media', 5, 'no', 'Meta');
INSERT INTO`tbl_sections` (`id`, `name`, `handle`, `sortorder`, `hidden`, `navigation_group`) VALUES (3, 'Authors', 'authors', 4, 'no', 'Meta');
INSERT INTO`tbl_sections` (`id`, `name`, `handle`, `sortorder`, `hidden`, `navigation_group`) VALUES (4, 'Categories', 'categories', 3, 'no', 'Meta');
INSERT INTO`tbl_sections` (`id`, `name`, `handle`, `sortorder`, `hidden`, `navigation_group`) VALUES (5, 'Pages', 'pages', 2, 'no', 'Content');

-- *** DATA:`tbl_sections_association` ***
INSERT INTO`tbl_sections_association` (`id`, `parent_section_id`, `parent_section_field_id`, `child_section_id`, `child_section_field_id`, `hide_association`) VALUES (47, 4, 6, 1, 14, 'no');
INSERT INTO`tbl_sections_association` (`id`, `parent_section_id`, `parent_section_field_id`, `child_section_id`, `child_section_field_id`, `hide_association`) VALUES (45, 2, 12, 1, 13, 'no');
INSERT INTO`tbl_sections_association` (`id`, `parent_section_id`, `parent_section_field_id`, `child_section_id`, `child_section_field_id`, `hide_association`) VALUES (44, 2, 12, 1, 5, 'no');
INSERT INTO`tbl_sections_association` (`id`, `parent_section_id`, `parent_section_field_id`, `child_section_id`, `child_section_field_id`, `hide_association`) VALUES (46, 3, 23, 1, 27, 'no');
INSERT INTO`tbl_sections_association` (`id`, `parent_section_id`, `parent_section_field_id`, `child_section_id`, `child_section_field_id`, `hide_association`) VALUES (50, 2, 12, 5, 31, 'no');
