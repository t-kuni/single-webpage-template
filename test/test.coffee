require('chai').should()
webdriver = require 'selenium-webdriver'
By = webdriver.By
_until = webdriver.until
test = require 'selenium-webdriver/testing'

# test.describe 'Google Search', -> 
#   driver = null
#
#   test.before -> 
#     driver = new webdriver.Builder()
#         .forBrowser 'phantomjs'
#         .build()
#
#   test.it 'should append query to title', -> 
#     driver.get 'http://www.google.com'
#     driver.findElement(By.name 'q').sendKeys 'webdriver'
#     driver.findElement(By.name 'btnG').click()
#     driver.wait _until.titleIs('webdriver - Google Search'), 1000
#
#   test.after -> 
#     driver.quit

test.describe 'TOPページのテスト（サンプル）', -> 
  driver = null

  test.before -> 
    driver = new webdriver.Builder()
        .forBrowser 'phantomjs'
        .build()

  test.it 'メッセージが表示されているか', -> 
    driver.get 'http://localhost:8000'
    driver.findElement(By.id 'message').getText().then (data) ->
      data.should.equal('こんにちは')

  test.it 'メッセージ3が表示されているか', -> 
    driver.get 'http://localhost:8000'
    driver.findElement(By.id 'message3').getText().then (data) ->
      data.should.equal('テスト実験用です')

  test.after -> 
    driver.quit
