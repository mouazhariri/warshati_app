import 'package:flutter/material.dart';
import 'package:sham/features/home/domain/entities/services_entity.dart';
import '../../../../src/core/widgets/cached_image_widget.dart';
import '../../../../src/infrastructure/api/endpoint/base_urls.dart';
class SelectableServicesRow extends StatefulWidget {
  final List<ServicesEntity> allServices;
  final List<int> initiallySelectedServiceIds;
  final Function(List<int>) onSelectionChanged;

  const SelectableServicesRow({
    Key? key,
    required this.allServices,
    required this.initiallySelectedServiceIds,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _SelectableServicesRowState createState() => _SelectableServicesRowState();
}

class _SelectableServicesRowState extends State<SelectableServicesRow> {
  late List<int> selectedServiceIds;

  @override
  void initState() {
    super.initState();
    selectedServiceIds = List.from(widget.initiallySelectedServiceIds);
  }

  void toggleSelection(int id) {
    setState(() {
      if (selectedServiceIds.contains(id)) {
        selectedServiceIds.remove(id);
      } else {
        selectedServiceIds.add(id);
      }
      widget.onSelectionChanged(selectedServiceIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.allServices.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          final service = widget.allServices[index];
          final isSelected = selectedServiceIds.contains(service.id);

          return GestureDetector(
            onTap: () => toggleSelection(service.id),
            child: Container(
              width: 80,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.2) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedImageWidget(
                    image: BaseUrls.baseUrl + service.image,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Theme.of(context).primaryColor : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
