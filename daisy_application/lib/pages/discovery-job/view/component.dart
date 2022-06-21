import 'package:daisy_application/core_services/models/category/category_model.dart';
import 'package:daisy_application/core_services/models/request/request_model.dart';
import 'package:daisy_application/core_services/models/user/user_model.dart';
import 'package:daisy_application/pages/discovery-job/view/stateless_component.dart';
import 'package:flutter/material.dart';

class JobInfoColumn extends StatefulWidget {
  const JobInfoColumn({Key? key}) : super(key: key);

  @override
  State<JobInfoColumn> createState() => _JobInfoColumnState();
}

class _JobInfoColumnState extends State<JobInfoColumn> {
  CategoryModel category = CategoryModel(
    1,
    'category description',
    'Logo',
    'type',
  );
  UserModel user = UserModel(
    1,
    'firstname',
    'lastname',
    'Select Technology, LLC ',
    'email',
    'role',
    'setting',
    'assets/images/portfolio/avatar.png',
    'District 7, Ho Chi Minh City, Vietnam ',
    'phone',
  );
  late RequestModel request = RequestModel(
    1,
    user,
    category,
    'Mobile Application Developer (iOS or/and Android)',
    'Select Technology is an IoT Solutions Company specializing in Smart City and Home Automation. Headquartered in Dallas, Texas and Remote locations in India, HCM City, and Ha Noi Viet Nam Select Technology has been a pioneer and innovator in IoT technology specifically in Smart Manufacturing, Smart City, and Home Automation. Select Technology’s mission is to provide a state-of-the-art, reliable, and comprehensive Home Automation and Smart City solution. \n\n Select Technology is an IoT Solutions Company specializing in Smart City and Home Automation. Headquartered in Dallas, Texas and Remote locations in India, HCM City, and Ha Noi Viet Nam Select Technology has been a pioneer and innovator in IoT technology specifically in Smart Manufacturing, Smart City, and Home Automation. Select Technology’s mission is to provide a state-of-the-art, reliable, and comprehensive Home Automation and Smart City solution.',
    1.0,
    '1',
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.only(left: 100.0, top: 30.0, right: 100.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              const RequestIntroList(),
              SizedBox(
                width: 1.0,
                height: size.height,
                child: Container(
                  color: Colors.grey.shade200,
                ),
              ),
              const SizedBox(
                width: 30.0,
              ),
              JobDetails(
                request: request,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestIntroList extends StatelessWidget {
  const RequestIntroList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryModel category = CategoryModel(
      1,
      'category description',
      'Logo',
      'type',
    );
    UserModel user = UserModel(
      1,
      'firstname',
      'lastname',
      'Select Technology, LLC ',
      'email',
      'role',
      'setting',
      'assets/images/portfolio/avatar.png',
      'District 7, Ho Chi Minh City, Vietnam ',
      'phone',
    );
    late RequestModel request = RequestModel(
      1,
      user,
      category,
      'Mobile Application Developer (iOS or/and Android)',
      'Select Technology is an IoT Solutions Company specializing in Smart City and Home Automation. Headquartered in Dallas, Texas and Remote locations in India, HCM City, and Ha Noi Viet Nam Select Technology has been a pioneer and innovator in IoT technology specifically in Smart Manufacturing, Smart City, and Home Automation. Select Technology’s mission is to provide a state-of-the-art, reliable, and comprehensive Home Automation and Smart City solution.',
      1.0,
      '1',
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          children: [
            IntroJobCard(
              request: request,
            ),
            IntroJobCard(
              request: request,
            ),
            IntroJobCard(
              request: request,
            ),
            IntroJobCard(
              request: request,
            ),
            IntroJobCard(
              request: request,
            ),
            IntroJobCard(
              request: request,
            ),
            IntroJobCard(
              request: request,
            ),
            IntroJobCard(
              request: request,
            ),
            IntroJobCard(
              request: request,
            ),
          ],
        ),
      ),
    );
  }
}