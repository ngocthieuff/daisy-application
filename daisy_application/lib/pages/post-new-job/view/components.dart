import 'package:daisy_application/pages/common/colors.dart';
import 'package:daisy_application/pages/common/responsive.dart';
import 'package:daisy_application/pages/common/style.dart';
import 'package:flutter/material.dart';

class CreateNewJobMobileBtn extends StatelessWidget {
  const CreateNewJobMobileBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: const Color(0xff262626),
      backgroundColor: Colors.white,
      tooltip: 'Find your new talent',
      onPressed: () {
        Navigator.pushNamed(context, '/post-new-job');
      },
      child: const Icon(Icons.add, size: 28),
    );
  }
}

class PostNewJobForm extends StatefulWidget {
  const PostNewJobForm({Key? key}) : super(key: key);

  @override
  State<PostNewJobForm> createState() => _PostNewJobFormState();
}

class _PostNewJobFormState extends State<PostNewJobForm> {
  List<String> categories = [
    'Web & app design',
    'Logo & identity',
    'Business & advertising',
    'Clothing & merchandise',
    'Book & magazine',
    'Packaging & label',
  ];
  String dropdownValue = 'Web & app design';

  final _formKey = GlobalKey<FormState>();
  List<Widget> requestChildren = [];
  int indexRequestChild = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double imgWidth =
        Responsive.isDesktop(context) ? size.width * 0.1 : size.width * 0.18;
    double childItemPadding =
        Responsive.isDesktop(context) ? size.width * 0.072 : size.width * 0.08;
    double formPaddingHorizontal =
        Responsive.isDesktop(context) ? size.width * 0.05 : size.width * 0.005;
    double formPaddingVertical =
        Responsive.isDesktop(context) ? size.width * 0.02 : size.width * 0.08;
    return SizedBox(
      width: size.width,
      height: 3000,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: formPaddingHorizontal, vertical: formPaddingVertical),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: Responsive.isDesktop(context)
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/post-new-job/general.png',
                      width: imgWidth),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Việc cần tuyển designer', style: Style.h6Bold),
                      CustomTextField(
                        fieldName: 'Đặt tên cụ thể cho công việc cần tuyển',
                        label: 'Tên dự án',
                        maxLines: 1,
                        validation: (value) {
                          if (value == null) {
                            return 'Giá trị nhập vào phải là số thập phân???';
                          }
                          return null;
                        },
                      ),
                      DropdownList(
                        categories: categories,
                        label: 'Chọn lĩnh vực cần tuyển',
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: Responsive.isDesktop(context)
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/post-new-job/description.png',
                      width: imgWidth),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.8,
                        child: Text('Thông tin đầy đủ về yêu cầu tuyển dụng',
                            style: Style.h6Bold),
                      ),
                      const CustomTextField(
                        fieldName:
                            'Nội dung chi tiết, và các đầu việc cần Designer thực hiện (càng chi tiết designer càng có đầy đủ thông tin để hoàn thiện sản phẩm)',
                        label: 'Mô tả dự án',
                        maxLines: 5,
                      ),
                      CustomTextField(
                        fieldName: 'Ngân sách dự án',
                        label: 'Ngân sách',
                        maxLines: 1,
                        validation: (value) {
                          if (value == null) {
                            return 'Giá trị nhập vào phải là số thập phân???';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(left: childItemPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: requestChildren.map(
                    (child) {
                      var index = requestChildren.indexOf(child);
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            tooltip: 'Xóa đầu việc này',
                            onPressed: () {
                              setState(() => {
                                    requestChildren.removeAt(index),
                                  });
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: Color(BuiltinColor.blue_gradient_01),
                            ),
                          ),
                          child,
                        ],
                      );
                    },
                  ).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: Responsive.isDesktop(context)
                        ? size.width * 0.62
                        : size.width * 0.33),
                child: TextButton.icon(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(
                      () => {
                        indexRequestChild++,
                        requestChildren.add(
                          ChildRequestForm(
                            index: indexRequestChild,
                          ),
                        )
                      },
                    );
                  },
                  label: const Text('Thêm đầu việc'),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(140.0, 60.0),
                  primary: const Color(BuiltinColor.blue_gradient_01),
                ),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text(
                  'Đăng việc',
                  style: TextStyle(fontSize: 16.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownList extends StatefulWidget {
  const DropdownList({Key? key, required this.label, required this.categories})
      : super(key: key);
  final String label;
  final List<String> categories;

  @override
  State<DropdownList> createState() => _DropdownListState(label, categories);
}

class _DropdownListState extends State<DropdownList> {
  late String _label;
  late List<String> _categories;
  late String dropdownValue;
  _DropdownListState(label, categories) {
    _label = label;
    _categories = categories;
    dropdownValue = _categories[0];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_label, style: Style.stringText),
        SizedBox(
          width: size.width * 0.8,
          height: 50,
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.expand_more),
                elevation: 16,
                style: Style.placeHolderText,
                onChanged: (String? newValue) {
                  setState(
                    () {
                      dropdownValue = newValue!;
                    },
                  );
                },
                items: _categories.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String fieldName;
  final String label;
  final int maxLines;
  final String? Function(String?)? validation;

  const CustomTextField({
    Key? key,
    required this.fieldName,
    required this.label,
    required this.maxLines,
    this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * 0.8,
          // child: Flexible(
          child: Text(fieldName, style: Style.stringText),
          // ),
        ),
        SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            validator: validation,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: label,
            ),
          ),
        ),
      ],
    );
  }
}

class ChildRequestForm extends StatefulWidget {
  const ChildRequestForm({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ChildRequestForm> createState() => _ChildRequestFormState(index);
}

class _ChildRequestFormState extends State<ChildRequestForm> {
  late int _index;
  _ChildRequestFormState(int index) {
    _index = index;
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Logo design',
      'Brand guide',
      'Business card',
      'Postcard, flyer or print',
      'Car, truck or van wrap',
      'PowerPoint template',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Đầu việc thứ $_index:',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.black.withOpacity(0.68),
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownList(
          categories: categories,
          label: 'Chọn lĩnh vực cần tuyển',
        ),
        CustomTextField(
          fieldName: 'Đặt tên cụ thể cho item $_index',
          label: 'Tên dự án',
          maxLines: 1,
          validation: (value) {
            if (value == null) {
              return 'Giá trị nhập vào phải là số thập phân???';
            }
            return null;
          },
        ),
        const CustomTextField(
          fieldName: 'Nội dung chi tiết',
          label: 'Mô tả',
          maxLines: 3,
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}