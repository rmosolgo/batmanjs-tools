generateHTML = require "../../generator/generators/html"

describe 'generating HTML', ->
  describe 'index', ->
    beforeEach ->
      code = generateHTML("body_parts/index", {
          appName: "Frankenstein"
        })
      @lines = code.split("\n")

    it 'gives a heading', ->
      expect(@lines[0]).toMatch(/Listing Body parts/)

    it 'makes a safe for-each iteration', ->
      forEachPattern = /data-foreach-bodypart="bodyParts"/
      expect(@lines[10]).toMatch(forEachPattern)

    it 'gives a `new` link', ->
      newLinkPattern = /data-route='routes.body_parts.new'/
      expect(@lines[26]).toMatch(newLinkPattern)

  describe 'show', ->
    beforeEach ->
      code = generateHTML("body_parts/show", {
          appName: "Frankenstein"
        })
      @lines = code.split("\n")

    it 'gives an edit link', ->
      expect(@lines[7]).toMatch(/data-route='routes.body_parts\[bodyPart\].edit'/)
    it 'gives a back link', ->
      expect(@lines[8]).toMatch(/data-route='routes.body_parts'/)

  describe 'edit', ->
    beforeEach ->
      code = generateHTML("body_parts/edit", {
          appName: "Frankenstein"
        })
      @lines = code.split("\n")

    it 'gives a heading', ->
      expect(@lines[0]).toMatch(/Editing Body part/)

  describe 'form', ->
    beforeEach ->
      @code = generateHTML("body_parts/form", {
          appName: "Frankenstein"
        })
      @lines = @code.split("\n")

    it 'saves on submit', ->
      expect(@lines[0]).toMatch(/data-event-submit='saveBodyPart'/)

    it 'gives a sumbit button', ->
      expect(@lines[3]).toMatch(/input type='submit' value='Save Body part'/)
