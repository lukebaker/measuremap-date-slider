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

var flashSource = _root.flashSource;
var contentLicense = _root.contentLicense;

var fSourceIsDefined = (flashSource != undefined && flashSource != "");
var fLicenseIsDefined = (contentLicense != undefined && contentLicense != "");

function itemHandler(obj, item)
{ 
 	getURL(item.url);
}

if(fSourceIsDefined || fLicenseIsDefined)
{
    var my_cm:ContextMenu = new ContextMenu(menuHandler); 
}

if(fSourceIsDefined)
{ 	
    var sourceMenuItem = new ContextMenuItem("View Source", itemHandler);
    sourceMenuItem.url = flashSource;
    
	my_cm.customItems.push(sourceMenuItem); 

	this.menu = my_cm;
}

if(fLicenseIsDefined)
{ 	
    var licenseMenuItem = new ContextMenuItem("View License", itemHandler);
    licenseMenuItem.url = contentLicense;
    
	my_cm.customItems.push(licenseMenuItem); 
	my_cm.hideBuiltInItems();
	this.menu = my_cm;
}
