/*initial_code.as
*Attached to the first frame on the _root level
*
*DESCRIPTION
* 	-Preloads stuff
* 	-Gets the XML and grabs some stuff with it
	-!!!!!  'howmany_days' is a very important variable !!!!!
	-does some other stuff too

*/
//comment to set file via HTML 
local = "no";//change to 'yes' if you want to test in Flash...for (trace). If set to 'no' these variables will come from HTML
if (local == "yes") {
	file_name = "xml/date_slider_data.xml";
	bar_color = "4433ff";
	box_color = "4433ff";
	line_color = "666666";
	slider_variable = "Birds";
	javascript = "no";
} else {
	javascript = "yes";
}
//Including Ladislav Zigo's popular MovieClip Tweening Prototype classes for Flash (http://laco.wz.cz/tween/)
#include "lmc_tween.as"
//Import the needed javascript stuff
import com.macromedia.javascript.JavaScriptProxy;
var proxy:JavaScriptProxy = new JavaScriptProxy(_root.lcId, this);


//function that loads the XML
XMLgo = function (file_name) {
	//loading_data = "loading data...";
	// random date to prevent cache
	randomedate = Math.round((Math.random()*10000000));
	var filename = file_name;
	loadwhatXML = file_name;
	my_xml = new XML();
	my_xml.onLoad = handleLoad;
	my_xml.load(loadwhatXML);
	my_xml.ignoreWhite = true;
	// once the XML is downloaded, let's get to work!
	function handleLoad(success) {
		if (success) {
			
			howmany_days = my_xml.firstChild.childNodes[0].childNodes.length;
			trace("Total Number of days");
			trace("\t"+"------     "+howmany_days);
			trace("");
			// First date
			first_date = my_xml.firstChild.childNodes[0].firstChild.attributes.date;
			trace("This is the first date");
			trace("\t"+"------     "+first_date);
			trace("");
			// Last date
			last_date = my_xml.firstChild.childNodes[0].childNodes[howmany_days-1].attributes.date;
			trace("This is today's Date");
			trace("\t"+"------     "+last_date);
			trace("");
			all_counts_total = 0;
			// make an array so we can sort the values
			var countList = new Array();
			for (i=0; i<howmany_days; i++) {
				// grab the values
				all_counts = Number(my_xml.firstChild.childNodes[0].childNodes[i].firstChild.toString());
				// put them in the array
				countList[i] = all_counts;
			}
			// now let's sort the array in descending order
			sortCountsDescending = function (element1, element2) { return element2-element1;};
			countList.sort(sortCountsDescending);
			// now, the first element in the array will be the highest value
			highest_value = countList[0];
			// let's just make sure
			trace("This is the HIGHEST amount of visitors ");
			trace("\t"+"------     "+countList[0]);
			trace("");
			trace("This is the LEAST amount of visitors ");
			trace("\t"+"------     "+countList[howmany_days-1]);
			trace("");
			trace("");
			// let's move on to the interface
			//gotoAndStop("interface");
			set_view_selector(howmany_days);
			// delete the bar pre-loader
			my_xml.completed = "yes";
		
		} else {
			trace("Did not get the XML...need data!!");
			loading_data = "Error: Can't get file name "+loadwhatXML;
			delete bar;
		}
	}
};
//intiate the loading of the XML

if (date_range == null) {
	//other possible date range values...
	//date_range = "20050608T18:58:44-20050630T18:58:44";
	//date_range = "20050809T18:58:44";
	
	date_range = "today";
	
	XMLgo(file_name);
} else {
	XMLgo(file_name);
}
//check to see how many nodes there are and if there are the correct amount
set_view_selector = function (howmany) {
	if (howmany == 30) {
		this.controller_mc.twomonth._visible = false;
		this.controller_mc.fourmonth._visible = false;
		gotoAndStop("interface");
	} else if (howmany == 60) {
		this.controller_mc.fourmonth._visible = false;
		gotoAndStop("interface");
	} else if (howmany == 120) {
		gotoAndStop("interface");
	} else {
		//_parent.slider_mc._visible = false;
		this.createTextField("my_txt", 1, 60, 50, 500, 100);
		my_txt.autoSize = true;
		var my_fmt:TextFormat = new TextFormat();
		my_fmt.color = 0x333333;
		my_fmt.font = "Tahoma";
		my_txt.text = "In the file "+file_name+" you have "+howmany+" nodes, and you need either 30, 60 or 120.";
		my_txt.setTextFormat(my_fmt);
	}
};


stop();
/*
    Flash View Source Include
    version .90
    Created by Mike Chambers
	mesh@macromedia.com
	http://www.markme.com/mesh/
    
    Usage :
    
    Place the viewFlashSource.as file in the same directory as your Flash
    source file (FLA), and add the following line to the main timeline of 
    your source file:
    
    #include viewFlashSource.as
    
    You can then specify the source URL through the flashParams 
    HTML tag / attribute.
	There are two values you can specify:
	
	flashSource : Points to a URL to download the source for the contnet.
	contentLicense : Points to the distribution / re-use license for the content.

    <embed src="example.swf" 
        quality="high" 
        bgcolor="#ffffff" 
        width="550" 
        height="400" 
        name="example" 
        align="middle" 
        allowScriptAccess="sameDomain" 
        type="application/x-shockwave-flash" 
        pluginspage="http://www.macromedia.com/go/getflashplayer"
        flashVars="flashSource=example%2Efla&contentLicense=http%3A%2F%2Fcreativecommons%2Eorg%2Flicenses%2Fby%2F2%2E0%2F"/>
        
    This is release under a Creative Commons license. More information can be
    found here:
    
    http://creativecommons.org/licenses/by/2.0/
*/
#include "com/macromedia/viewFlashSource.as"
//
//var my_cm:ContextMenu = new ContextMenu();
//my_cm.hideBuiltInItems();
//my_cm.builtInItems.print = true;
//this.menu = my_cm;