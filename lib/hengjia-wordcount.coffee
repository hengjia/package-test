HengjiaWordcountView = require './hengjia-wordcount-view'
{CompositeDisposable} = require 'atom'

module.exports = HengjiaWordcount =
  hengjiaWordcountView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @hengjiaWordcountView = new HengjiaWordcountView(state.hengjiaWordcountViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @hengjiaWordcountView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'hengjia-wordcount:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @hengjiaWordcountView.destroy()

  serialize: ->
    hengjiaWordcountViewState: @hengjiaWordcountView.serialize()

  toggle: ->
    console.log 'HengjiaWordcount was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      # editor = atom.workspace.getActiveTextEditor()
      # words = editor.getText().split(/\s+/).length
      # words = atom.workspace.getActiveTextEditor().getText().split(/\s+/).length
      editor = atom.workspace.getActiveTextEditor()
      words = editor.getText().split(/\s+/).length
      @hengjiaWordcountView.setCount(words)
      @modalPanel.show()
