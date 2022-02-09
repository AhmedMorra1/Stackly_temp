import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main(){
  group('Empty App',(){

    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null){
        await driver!.close();
      }
    });

    test('find widgets',() async{
      final text1 = find.byValueKey('Today');
      final text2 = find.text('No supplements');
      final text3 = find.text('Stack');
      expect(await driver!.getText(text1),'Today');
      expect(await driver!.getText(text2),'No supplements');
      expect(await driver!.getText(text3),'Stack');

    });

    test('go to stack page',() async {
      await driver!.tap(find.text('Stack'));
      final text4 = find.byValueKey('Stack');
      expect(await driver!.getText(text4),'Stack');
    });

    test('go to new page and cancel',() async {
      await driver!.tap(find.byType('FloatingActionButton'));
      final text4 = find.text('Add New');
      expect(await driver!.getText(text4),'Add New');
      await driver!.tap(find.text('Cancel'));
      final text2 = find.text('No supplements');
      expect(await driver!.getText(text2),'No supplements');
    });

    test('go to new page and add save new supplement',() async {
      await driver!.tap(find.byType('FloatingActionButton'));
      final text4 = find.text('Add New');
      expect(await driver!.getText(text4),'Add New');
      //enter supplement name
      final supplementTextField = find.byValueKey('Supplement Name TextField');
      await driver!.tap(supplementTextField);
      await driver!.enterText('Lions Mane');
      //enter package count
      final packageCountTextField = find.byValueKey('Package Count TextField');
      await driver!.tap(packageCountTextField);
      await driver!.enterText('90');
      //choose serving type
      await driver!.tap(find.text('Capsules'));
      await driver!.tap(find.text('Tablets'));
      //enter current count
      final currentCountTextField = find.byValueKey('Current Count TextField');
      await driver!.tap(currentCountTextField);
      await driver!.enterText('89');
      //enter serving size
      final servingSizeTextField = find.byValueKey('Serving Size TextField');
      await driver!.tap(servingSizeTextField);
      await driver!.enterText('1');
      //select instructions
      await driver!.tap(find.text('On Empty Stomach'));
      //add serving time
      await driver!.tap(find.text('Add Time'));
      await driver!.tap(find.text('OK'));
      //save the supplement to the database
      await driver!.tap(find.text('Save'));
    });

    test('edit the supplements data',() async {
      //find the name of the supplements in the supplement list
      final text5 = find.text('Lions Mane');
      expect(await driver!.getText(text5),'Lions Mane');
      //go to the edit page
      await driver!.tap(find.text('Lions Mane'));
      //edit the serving type
      await driver!.tap(find.text('Tablets'));
      await driver!.tap(find.text('Capsules'));
      //save
      await driver!.tap(find.text('Save'));
      //check the saved if the data updated
      final text6 = find.text('Capsules');
      expect(await driver!.getText(text6),'Capsules');
    });

    test('take a supplement and check the current count drop',() async {
      //go to the today page
      await driver!.tap(find.text('Today'));
      //click on the check box
      await driver!.tap(find.byType('RoundCheckBox'));
      //go to stack page
      await driver!.tap(find.text('Stack'));
      //check the current count is 88
      final text6 = find.text('88');
      expect(await driver!.getText(text6),'88');
    });

    test('delete the supplement', ()async{
      await driver!.tap(find.text('Lions Mane'));
      await driver!.tap(find.byValueKey('delete'));
      await driver!.tap(find.text('Yes'));
      //check if deleted
      final text6 = find.text('No supplements');
      expect(await driver!.getText(text6),'No supplements');
    });
  });
}