import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String originalPrice;
  final String duration;
  final String lessons;
  final double rating;
  final String students;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.duration,
    required this.lessons,
    required this.rating,
    required this.students,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Image Placeholder
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.play_circle_outline,
                  size: 48,
                  color: AppTheme.primaryOrange,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Title and Description
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 8),
              
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 16),
              
              // Course Stats
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 16,
                    color: AppTheme.warning,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    rating.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.people_outline,
                    size: 16,
                    color: AppTheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    students,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    duration,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              Row(
                children: [
                  Icon(
                    Icons.play_lesson_outlined,
                    size: 16,
                    color: AppTheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    lessons,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Price and Action
              Row(
                children: [
                  Text(
                    price,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.primaryOrange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    originalPrice,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryOrange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Enroll Now',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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

