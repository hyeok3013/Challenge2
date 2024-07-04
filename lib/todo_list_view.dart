import 'package:flutter/material.dart';

class TodoListView extends StatefulWidget {
  final List<String> todoList;
  final Function writeLocalData;

  const TodoListView(
      {super.key, required this.todoList, required this.writeLocalData});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    return (widget.todoList.isEmpty)
        ? const Center(
            child: Text(
              "No items on the list",
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.builder(
            itemCount: widget.todoList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red,
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.check),
                      )
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    widget.todoList.removeAt(index);
                  });
                  widget.writeLocalData();
                },
                child: ListTile(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget.todoList.removeAt(index);
                              });
                              widget.writeLocalData();
                              Navigator.pop(context);
                            },
                            child: const Text("Task done!"),
                          ),
                        );
                      },
                    );
                  },
                  title: Text(widget.todoList[index]),
                ),
              );
            },
          );
  }
}
