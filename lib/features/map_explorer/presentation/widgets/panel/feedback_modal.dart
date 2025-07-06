import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Enum definitions should match the ones in your Supabase database exactly.
enum FeedbackType {
  incorrectLocation('INCORRECT_LOCATION', 'Incorrect Location'),
  doesNotExist('DOES_NOT_EXIST', 'Doesn\'t Exist Here'),
  wrongCategory('WRONG_CATEGORY', 'Wrong Category'),
  outdatedInfo('OUTDATED_INFO', 'Outdated Information'),
  duplicate('DUPLICATE', 'Duplicate Spot'),
  doesntFitApp('DOESNT_FIT_APP', 'Doesn\'t Fit the App'),
  other('OTHER', 'Other');

  const FeedbackType(this.dbValue, this.displayValue);
  final String dbValue;
  final String displayValue;
}

class FeedbackModal extends StatefulWidget {
  final Spot spot;

  const FeedbackModal({super.key, required this.spot});

  @override
  State<FeedbackModal> createState() => _FeedbackModalState();
}

class _FeedbackModalState extends State<FeedbackModal> {
  FeedbackType? _selectedType;
  final _notesController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitFeedback() async {
    if (_selectedType == null) {
      // Show an error if no type is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a feedback type.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final userId = context.read<AuthBloc>().state.whenOrNull(
      authenticated: (user, profile) => user.id,
    );

    if (userId == null) {
      // This should ideally not happen if the button is only shown to logged-in users
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must be logged in to submit feedback.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Supabase.instance.client.from('spot_feedback').insert({
        'spot_id': widget.spot.id,
        'user_id': userId,
        'feedback_type': _selectedType!.dbValue,
        'notes': _notesController.text.isNotEmpty
            ? _notesController.text
            : null,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thank you for your feedback!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit feedback: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Report an issue with "${widget.spot.name}"',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          ...FeedbackType.values.map(
            (type) => RadioListTile<FeedbackType>(
              title: Text(type.displayValue),
              value: type,
              groupValue: _selectedType,
              onChanged: (value) => setState(() => _selectedType = value),
            ),
          ),
          if (_selectedType == FeedbackType.other)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _notesController,
                decoration: const InputDecoration(
                  hintText: 'Please provide more details...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submitFeedback,
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Submit Feedback'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}
