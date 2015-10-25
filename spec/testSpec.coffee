describe "Hello Test", ->

  beforeEach ->
    document.body.innerHTML = window.__html__['dist/index.html']

  it "test2", ->
    a = 'test1'
    e = 'test1'
    console.log('aaa')
    console.log($('#message2').text())
    return expect(a).toEqual(e)
