// SPPDirectoryPickerTableViewController.mm
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

#import "SPPDirectoryPickerTableViewController.h"
#import "../MobileSafari/Shared.h"

@implementation UITableViewController (FooterFix)
- (void)fixFooterColors
{

}
@end

@implementation SPPDirectoryPickerTableViewController

- (void)setUpRightBarButtonItems
{
	//UIBarButtonItem to choose current directory
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[localizationManager
											 localizedSPStringForKey:@"CHOOSE"] style:UIBarButtonItemStylePlain
						  target:self action:@selector(chooseButtonPressed)];
}

- (void)chooseButtonPressed
{
	NSNumber* isWritable;
	[self.directoryURL getResourceValue:&isWritable forKey:NSURLIsWritableKey error:nil];

	if([isWritable boolValue])
	{
		//Path is writable -> create alert to pick file name
		UIAlertController * confirmationAlert = [UIAlertController alertControllerWithTitle:
							 [localizationManager localizedSPStringForKey:@"CHOOSE_PATH_CONFIRMATION_TITLE"]
							 message:[NSString stringWithFormat:[localizationManager localizedSPStringForKey:@"CHOOSE_PATH_CONFIRMATION_MESSAGE"], self.directoryURL.path]
							 preferredStyle:UIAlertControllerStyleAlert];

		//Create yes action to pick a path
		UIAlertAction* yesAction = [UIAlertAction actionWithTitle:
					    [localizationManager localizedSPStringForKey:@"YES"]
					    style:UIAlertActionStyleDefault handler:^(UIAlertAction *addAction)
		{
			//Dismiss picker
			[self dismissViewControllerAnimated:YES completion:^
			{
				//Finish picking
				[((SPPDirectoryPickerNavigationController*)self.navigationController).pinnedLocationsDelegate
				 directoryPickerFinishedWithPath:self.directoryURL.path];
			}];
		}];

		[confirmationAlert addAction:yesAction];


		//Create no action to continue picking a path
		UIAlertAction* noAction = [UIAlertAction actionWithTitle:
					   [localizationManager localizedSPStringForKey:@"NO"]
					   style:UIAlertActionStyleDefault handler:nil];

		//Add action
		[confirmationAlert addAction:noAction];

		//Create action to close the picker
		UIAlertAction* closePickerAction = [UIAlertAction actionWithTitle:
						    [localizationManager localizedSPStringForKey:@"CANCEL_PICKER"]
						    style:UIAlertActionStyleDefault handler:^(UIAlertAction *addAction)
		{
			//Dismiss picker
			[self dismiss];
		}];

		//Add action
		[confirmationAlert addAction:closePickerAction];

		//Present alert
		[self presentViewController:confirmationAlert animated:YES completion:nil];
	}
	else
	{
		//Path is not writable -> Create error alert
		UIAlertController * errorAlert = [UIAlertController alertControllerWithTitle:
						  [localizationManager localizedSPStringForKey:@"ERROR"]
						  message:[localizationManager localizedSPStringForKey:@"PERMISSION_ERROR_MESSAGE"]
						  preferredStyle:UIAlertControllerStyleAlert];

		//Create action to close the alert
		UIAlertAction* closeAction = [UIAlertAction actionWithTitle:
					      [localizationManager localizedSPStringForKey:@"CLOSE"]
					      style:UIAlertActionStyleDefault handler:nil];

		//Add action
		[errorAlert addAction:closeAction];

		//Create action to close the picker
		UIAlertAction* closePickerAction = [UIAlertAction actionWithTitle:
						    [localizationManager localizedSPStringForKey:@"CANCEL_PICKER"]
						    style:UIAlertActionStyleDefault handler:^(UIAlertAction *addAction)
		{
			//Close picker
			[self dismiss];
		}];

		//Add action
		[errorAlert addAction:closePickerAction];

		//Present alert
		[self presentViewController:errorAlert animated:YES completion:nil];
	}
}

@end
