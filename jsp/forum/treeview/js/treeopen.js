	
function openFolderInTree(linkID) 
{
	var folderObj;
	folderObj = findObj(linkID);
	folderObj.forceOpeningOfAncestorFolders();
	if (!folderObj.isOpen)
		clickOnNodeObj(folderObj);
} 
