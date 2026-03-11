import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/qr_bloc.dart';
import 'package:intl/intl.dart';

import '../scan_result_screen.dart';
import '../qr_view_screen.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded),
            onPressed: () => _showClearConfirm(context),
          ),
        ],
      ),
      body: BlocBuilder<QRBloc, QRState>(
        builder: (context, state) {
          if (state is QRLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is QRHistoryLoaded) {
            final history = state.history;
            if (history.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history_rounded, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No history found', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final qr = history[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: qr.isGenerated
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(
                      qr.isGenerated ? Icons.qr_code_rounded : Icons.qr_code_scanner_rounded,
                      size: 20,
                      color: qr.isGenerated
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  title: Text(
                    qr.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${qr.type.name} • ${DateFormat('MMM dd, HH:mm').format(qr.createdAt)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: () {
                      context.read<QRBloc>().add(DeleteQR(qr.id));
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => qr.isGenerated
                            ? QRViewScreen(qr: qr)
                            : ScanResultScreen(qr: qr),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  void _showClearConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text('Are you sure you want to delete all history? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<QRBloc>().add(ClearHistory());
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
