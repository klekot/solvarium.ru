class TodoStore
  @displayName: 'TodoStore'

  constructor: ->
    @bindActions(TodoActions)
    @todos = []

    @exportPublicMethods(
      { 
        getTodos: @getTodos
      }
    )

  onInitData: (props)->
    @todos = props.todos

  onSubmitTodo: (name)->
    console.log(name)
    $.ajax
      type: 'POST'
      url: '/todos'
      data:
        todo:
          name: name
          user_id: gon.user_id
          project_id: gon.project_id
          checked: false
      success: (response)=>
        @todos.push(response)
        @emitChange()
      error: (response)=>
        console.log('error')
        console.log(response)
    return false

  onCheckTodo: (todo_id)->
    $.ajax
      type: 'DELETE'
      url: "/todos/#{todo_id}"
      success: (response)=>
        _.find(@todos, { id: response.id} ).checked = true
        @emitChange()
      error: (response)=>
        console.log('error')
        console.log(response)

  onUncheckTodo: (todo_id)->
    $.ajax
      type: 'PUT'
      url: "/todos/#{todo_id}"
      success: (response)=>
        _.find(@todos, { id: response.id} ).checked = false
        @emitChange()
      error: (response)=>
        console.log('error')
        console.log(response)
    return false

  getTodos: ()->
    @getState().todos

window.TodoStore = alt.createStore(TodoStore)