class TodoActions
  constructor: ->
    @generateActions(
      'initData',
      'submitTodo',
      'checkTodo',
      'uncheckTodo'
    )

window.TodoActions = alt.createActions(TodoActions)