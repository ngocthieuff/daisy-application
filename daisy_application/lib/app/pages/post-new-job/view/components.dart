import 'package:daisy_application/app/common/colors.dart';
import 'package:daisy_application/app/common/responsive.dart';
import 'package:daisy_application/app/common/style.dart';
import 'package:daisy_application/app/pages/post-new-job/model/post_new_job_state.dart';
import 'package:daisy_application/core_services/common/response_handler.dart';
import 'package:daisy_application/core_services/http/category/category_rest_api.dart';
import 'package:daisy_application/core_services/models/category/category_model.dart';
import 'package:daisy_application/core_services/models/request/request_model.dart';
import 'package:daisy_application/service_locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:daisy_application/common/safety_utils.dart';
import 'package:daisy_application/common/access_utils.dart';

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
  final VoidCallback? onSubmitted;
  const PostNewJobForm({super.key, this.onSubmitted});

  @override
  State<PostNewJobForm> createState() => _PostNewJobFormState();
}

class _PostNewJobFormState extends State<PostNewJobForm> {
  @override
  initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  List<Widget> requestChildren = [];
  int indexRequestChild = 0;

  String datetimedisplay =
      DateTime.now().add(const Duration(days: 3)).toString();
  RequestModel newRequest = RequestModel.init();

  @override
  Widget build(BuildContext context) {
    var model = context.watch<PostNewJobState>();
    Size size = MediaQuery.of(context).size;
    double imgWidth =
        Responsive.isDesktop(context) ? size.width * 0.05 : size.width * 0.18;
    double childItemPadding =
        Responsive.isDesktop(context) ? size.width * 0.028 : size.width * 0.08;
    double formPaddingHorizontal =
        Responsive.isDesktop(context) ? size.width * 0.15 : size.width * 0.005;
    double formPaddingVertical =
        Responsive.isDesktop(context) ? size.width * 0.02 : size.width * 0.08;

    return SizedBox(
      width: size.width,
      height: 3000,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(
              left: formPaddingHorizontal, top: formPaddingVertical),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: Responsive.isDesktop(context)
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/post-new-job/general.png',
                      width: imgWidth),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Việc cần tuyển designer', style: Style.h6Bold),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CustomTextField(
                        validation: (value) => value
                            .isNone()
                            .thenReturn('Tên dự án không thể bỏ trống'),
                        fieldName: 'Đặt tên cụ thể cho công việc cần tuyển',
                        label: 'Tên dự án',
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const DropdownList(
                        label: 'Chọn lĩnh vực cụ thể',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                crossAxisAlignment: Responsive.isDesktop(context)
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/post-new-job/description.png',
                      width: imgWidth * 0.95),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.6,
                        child: Text('Thông tin đầy đủ về yêu cầu tuyển dụng',
                            style: Style.h6Bold),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CustomTextField(
                        fieldName:
                            'Nội dung chi tiết, và các đầu việc cần Designer thực hiện (càng chi tiết designer càng có đầy đủ thông tin để hoàn thiện sản phẩm)',
                        label: 'Mô tả dự án',
                        validation: (value) => value
                            .isNone()
                            .thenReturn('Mô tả dự án không thể bỏ trống'),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CustomTextField(
                        fieldName: 'Ngân sách dự án',
                        label: 'Ngân sách',
                        hintText: '100',
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        validation: (value) => value
                            .isNone()
                            .thenReturn('Ngân sách không thể bỏ trống'),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        height: Responsive.isDesktop(context) ? 50.0 : 72.0,
                        width: Responsive.isDesktop(context) ? 700.0 : 300.0,
                        child: TextButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime:
                                    DateTime.now().add(const Duration(days: 1)),
                                maxTime: DateTime(2025, 6, 7, 05, 09),
                                onChanged: (date) {}, onConfirm: (date) {
                              model.parentRequest.timeline = date;
                              setState(() {
                                datetimedisplay = date.toString();
                              });
                            }, locale: LocaleType.vi);
                          },
                          child: SizedBox(
                            width: Responsive.isDesktop(context)
                                ? size.width * 0.5
                                : size.width * 0.7,
                            height: 300.0,
                            child: Responsive.isDesktop(context)
                                ? Row(
                                    children: [
                                      const Icon(Icons.schedule,
                                          color: Colors.black),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        'Chọn thời hạn dự án:',
                                        style: Style.stringText,
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      Text(
                                        datetimedisplay,
                                        style: const TextStyle(
                                          fontSize: 15.5,
                                          color: Color(
                                              BuiltinColor.blue_gradient_01),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5.0),
                                      Row(
                                        children: [
                                          const Icon(Icons.schedule,
                                              color: Colors.black),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Chọn thời hạn dự án:',
                                            style: Style.stringText,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          datetimedisplay,
                                          style: const TextStyle(
                                            fontSize: 15.5,
                                            color: Color(
                                                BuiltinColor.blue_gradient_01),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Responsive.isDesktop(context) ? 20.0 : 5.0),
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
                              setState(
                                () => {
                                  requestChildren.removeAt(index),
                                },
                              );
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
                        ? size.width * 0.665
                        : size.width * 0.28),
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
                        ),
                      },
                    );
                  },
                  label: const Text(
                    'Thêm đầu việc',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: Responsive.isDesktop(context) ? 80.0 : 70.0,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(140.0, 60.0),
                        primary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Hủy bỏ',
                        style: TextStyle(
                          fontSize: 16.5,
                          color: Color(BuiltinColor.blue_gradient_01),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Responsive.isDesktop(context) ? 20.0 : 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: Responsive.isDesktop(context) ? 50.0 : 0.0,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(140.0, 60.0),
                        primary: const Color(BuiltinColor.blue_gradient_01),
                      ),
                      onPressed: () => _formKey.currentState!.validate().then(
                          () => widget.onSubmitted
                              .then(() => widget.onSubmitted!())),
                      child: const Text(
                        'Đăng việc',
                        style: TextStyle(fontSize: 16.5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownList extends StatefulWidget {
  const DropdownList({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  State<DropdownList> createState() => _DropdownListState(label);
}

class _DropdownListState extends State<DropdownList> {
  List<CategoryModel> _categories = [];

  @override
  initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    CategoryRestApi _categoryClient = locator.get();
    Result result = await _categoryClient.getParentCategories().Value();
    setState(() {
      _categories = result.data.parentCategories;
      dropdownValue = _categories[0];
    });
  }

  late String _label;
  CategoryModel dropdownValue = CategoryModel.init()..name = '';

  _DropdownListState(
    label,
  ) {
    _label = label;
  }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<PostNewJobState>();
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_label, style: Style.stringText),
        const SizedBox(height: 5.0),
        SizedBox(
          width: Responsive.isDesktop(context)
              ? size.width * 0.6
              : size.width * 0.7,
          height: 50,
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<CategoryModel>(
                value: dropdownValue,
                icon: const Icon(Icons.expand_more),
                elevation: 16,
                style: Style.placeHolderText,
                onChanged: (CategoryModel? newValue) {
                  model.parentRequest.category = newValue!;
                  model.parentRequest.category = newValue;
                  setState(
                    () {
                      dropdownValue = newValue;
                    },
                  );
                },
                items: _categories.map<DropdownMenuItem<CategoryModel>>(
                  (CategoryModel value) {
                    return DropdownMenuItem<CategoryModel>(
                      value: value,
                      child: Text(value.name!),
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
  final int? index;
  final String? hintText;
  final TextInputType? keyboardType;
  final GlobalKey<FormState>? formKey;

  const CustomTextField({
    Key? key,
    required this.fieldName,
    required this.label,
    required this.maxLines,
    this.validation,
    this.index,
    this.keyboardType,
    this.formKey,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var model = context.watch<PostNewJobState>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * 0.5,
          child: Text(fieldName, style: Style.stringText),
        ),
        const SizedBox(height: 5.0),
        SizedBox(
          width: Responsive.isDesktop(context)
              ? size.width * 0.6
              : size.width * 0.7,
          child: TextFormField(
            key: formKey,
            keyboardType: keyboardType,
            onChanged: (value) {
              if (label == 'Tên dự án') {
                model.parentRequest.title = value;
              }
              if (label == 'Mô tả dự án') {
                model.parentRequest.description = value;
              }
              if (label == 'Ngân sách') {
                model.parentRequest.budget = double.parse(value);
              }
              if (index != null) {
                if (model.parentRequest.items.length < index!) {
                  model.parentRequest.items.add(RequestModel.init()
                    ..status = ' '
                    ..budget = 0
                    ..timeline = model.parentRequest.timeline);
                }
                if (label == 'Tên đầu việc') {
                  model.parentRequest.items[index! - 1].title = value;
                }
                if (label == 'Mô tả đầu việc') {
                  model.parentRequest.items[index! - 1].description = value;
                }
              }
            },
            validator: validation,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
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
    var model = context.watch<PostNewJobState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Đầu việc thứ $_index:',
          style: TextStyle(
            fontSize: 17.5,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        DropdownChildrenList(
          parentName: model.parentRequest.category!.name!,
          label: 'Chọn lĩnh vực cụ thể cho đầu việc',
          index: _index,
        ),
        const SizedBox(
          height: 5.0,
        ),
        CustomTextField(
          fieldName: 'Đặt tên cụ thể cho item $_index',
          label: 'Tên đầu việc',
          maxLines: 1,
          validation: (value) =>
              value.isNone().thenReturn('Tên đầu việc không thể bỏ trống'),
          index: _index,
        ),
        const SizedBox(
          height: 5.0,
        ),
        CustomTextField(
          fieldName: 'Nội dung chi tiết',
          label: 'Mô tả đầu việc',
          maxLines: 1,
          index: _index,
        ),
        const SizedBox(height: 10.0),
        Container(
          color: Colors.grey.shade500,
          child: const SizedBox(height: 1.0, width: 200.0),
        ),
        const SizedBox(height: 25.0),
      ],
    );
  }
}

class DropdownChildrenList extends StatefulWidget {
  const DropdownChildrenList(
      {Key? key,
      required this.label,
      required this.parentName,
      required this.index})
      : super(key: key);
  final String label;
  final String parentName;
  final int index;
  @override
  State<DropdownChildrenList> createState() =>
      _DropdownChildrenListState(label, parentName, index);
}

class _DropdownChildrenListState extends State<DropdownChildrenList> {
  List<CategoryModel> _categories = [];

  @override
  initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    CategoryRestApi _categoryClient = locator.get();
    Result result = await _categoryClient
        .getChildrenCategoriesByParentName(_parentName)
        .Value();
    setState(() {
      _categories = result.data.childCategories;
      dropdownValue = _categories[0];
    });
  }

  late String _label;
  late String _parentName;
  late int _index;
  CategoryModel dropdownValue = CategoryModel.init()..name = '';

  _DropdownChildrenListState(
    label,
    parentName,
    index,
  ) {
    _label = label;
    _parentName = parentName;
    _index = index;
  }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<PostNewJobState>();
    Size size = MediaQuery.of(context).size;

    if (model.parentRequest.items.length < _index) {
      model.parentRequest.items.add(RequestModel.init()
        ..status = 'AVAILABLE'
        ..budget = 0
        ..timeline = model.parentRequest.timeline);
    }
    model.parentRequest.items[_index - 1].category = dropdownValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_label, style: Style.stringText),
        const SizedBox(height: 5.0),
        SizedBox(
          width: Responsive.isDesktop(context)
              ? size.width * 0.6
              : size.width * 0.7,
          height: 50,
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<CategoryModel>(
                value: dropdownValue,
                icon: const Icon(Icons.expand_more),
                elevation: 16,
                style: Style.placeHolderText,
                onChanged: (CategoryModel? newValue) {
                  model.parentRequest.items[_index - 1].category = newValue;
                  setState(
                    () {
                      dropdownValue = newValue!;
                    },
                  );
                },
                items: _categories.map<DropdownMenuItem<CategoryModel>>(
                  (CategoryModel value) {
                    return DropdownMenuItem<CategoryModel>(
                      value: value,
                      child: Text(value.name!),
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
