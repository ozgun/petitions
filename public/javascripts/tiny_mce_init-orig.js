tinyMCE.init({
		// General options
		mode : "textareas",
    	language : "en",
		//mode : "exact",
		//elements: "elm1, elm2",
		//elements: "elm1",
		//mode : "specific_textareas",
		//textarea_trigger : "mce_editable",
		editor_selector : "tinyMceEditor",
		theme : "advanced",
		//theme : "simple",
		//plugins : "safari,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",
		//plugins : "advimage",
		//plugins : "media,preview",

    // keep image urls absolute, because we use images in emails/newsletter and rss
    //document_base_url : "http://localhost:3000",
    relative_urls : false,
    remove_script_host : false,

		// Theme options
    theme_advanced_layout_manager : "SimpleLayout",
    //theme_advanced_source_editor_width : 700,
    //theme_advanced_source_editor_height : 600,
		//theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		//theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		//theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
		//theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
		//theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",
    //theme_advanced_buttons1_add : "emotions",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,
    theme_advanced_resize_horizontal: false,
    theme_advanced_disable : "undo,redo,anchor,help,styleselect",
		theme_advanced_buttons2 : false,
		theme_advanced_buttons3 : false,
    //theme_advanced_buttons1_add : "|,bullist,numlist,|,outdent,indent,|,link,unlink,image,cleanup,code,|,hr,removeformat,visualaid,|,sub,sup,|,charmap",
    theme_advanced_buttons1_add : "fontselect,fontsizeselect,forecolor,backcolor,|,link,unlink,image,charmap,|,hr,sub,sup,|,code,|",

		// Example content CSS (should be your site CSS)
		//content_css : "css/content.css",
		//content_css : "/stylesheets/tinymce/tiny_mce_sites.css?" + new Date().getTime(),

		// Replace values for the template plugin
		//template_replace_values : {
		//	username : "Some User",
		//	staffid : "991234"
		//}

		// Drop lists for link/image/media/template dialogs
		//template_external_list_url : "lists/template_list.js",
		//external_link_list_url : "lists/link_list.js",
		//media_external_list_url : "lists/media_list.js",
    // IMPORTANT!!! DO NOT append "," after the last element. Otherwise it won't work with IE!!!
		//external_image_list_url : "/javascripts/tiny_mce/lists/image_list.js",
  });
