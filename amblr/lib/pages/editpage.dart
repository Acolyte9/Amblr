import 'package:flutter/material.dart';

class DocumentEditorScreen extends StatefulWidget {
  // final String documentId;
  final String documentName;

  const DocumentEditorScreen({
    super.key,
    // required this.documentId,
    required this.documentName,
  });

  @override
  State<DocumentEditorScreen> createState() {
    return _DocumentEditorScreenState();
  }
}

class _DocumentEditorScreenState extends State<DocumentEditorScreen> {
  // final DocumentStorage storage = DocumentStorage();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.documentName;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> saveDocument() async {
    setState(() {
      isSaving = true;
    });

    final title = titleController.text.trim().isEmpty
        ? 'Untitled Document'
        : titleController.text.trim();
    titleController.text = title;

    // try {
    //   await storage.updateDocument(
    //     widget.documentId,
    //     title: title,
    //     content: textController.text,
    //   );

    //   if (!mounted) return;

    //   titleController.text = title;

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Document saved!')),
    //   );
    // } catch (error) {
    //   if (!mounted) return;

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Could not save document: $error')),
    //   );
    // } finally {
    //   if (mounted) {
    //     setState(() {
    //       isSaving = false;
    //     });
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 255, 200),
        title: TextField(
          controller: titleController,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            hintText: 'Untitled Document',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            onPressed: isSaving ? null : saveDocument,
            icon: const Icon(Icons.save),
            tooltip: 'Save document',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: textController,
          maxLines: null,
          expands: true,
          textAlignVertical: TextAlignVertical.top,
          decoration: const InputDecoration(
            hintText: 'Start writing your document...',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
