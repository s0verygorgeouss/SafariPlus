// SPPUploadDownloadListController.mm
// (c) 2017 - 2019 opa334

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

#import "SPPUploadDownloadListController.h"
#import "SafariPlusPrefs.h"

@implementation SPPUploadDownloadListController

- (NSString*)plistName
{
	return @"UploadsDownloads";
}

- (NSString*)title
{
	return [localizationManager localizedSPStringForKey:@"UPLOADS_AND_DOWNLOADS"];
}

- (NSArray*)sectionValues
{
	return @[@0, @1];
}

- (NSArray*)sectionTitles
{
	return @[[localizationManager localizedSPStringForKey:@"FILE_BROWSER"], [localizationManager localizedSPStringForKey:@"DOWNLOADS"]];
}

- (NSArray *)instantDownloadValues
{
	return @[@1, @2];
}

- (NSArray *)instantDownloadTitles
{
	NSMutableArray* titles = [@[@"DOWNLOAD", @"DOWNLOAD_TO"] mutableCopy];
	for(int i = 0; i < titles.count; i++)
	{
		titles[i] = [localizationManager localizedSPStringForKey:titles[i]];
	}
	return titles;
}

@end
