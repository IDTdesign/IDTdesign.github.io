# DocPad Configuration File
# http://docpad.org/docs/config

docpadConfig = {
	templateData:
		site:
			# The default title of our website.
			title: "IDT design"

			# The production url of our website.
			url: "//idtdesign.github.io"

			# The website description (for SEO).
			description: """
				The place where IDT design styleguides live
				"""

			# The website keywords (for SEO) separated by commas.
			keywords: """
				idt, boss, revolution
				"""

			# The cascading stylesheets for the site.
			# The website's styles
			styles: [
				'/styles/docs.css'
			]

			# The JavaScript files for the site.
			scripts: [
			]

		# -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title} | #{@site.title}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.title

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site's description
			@document.description or @site.description

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			@site.keywords.concat(@document.keywords or []).join(', ')

		isActive: (s) ->
			# current links in navigation
			if s == @document.url
				"active"

		# Post part before “cut”
		cuttedContent: (content) ->
			if @hasReadMore content
				cutIdx = content.search @cutTag
				content[0..cutIdx-1]
			else
				content

		# Has “cut”?
		hasReadMore: (content) ->
			content and ((content.search @cutTag) isnt -1)

		wspToDash: (s) ->
			s and (s
				.replace /\ /g, "-"
			)


	ignoreCustomPatterns: /^\S*([.]less)/gm

	plugins:
		ghpages:
			deployRemote: 'deploy'
			deployBranch: 'master'
		marked:
			gfm: true
			breaks: true
		highlightjs:
			aliases:
				missinglanguage: 'alternativelanguage'
		grunt:
			# writeAfter: ['prepare', 'postprocess']
			writeAfter: false
			writeBefore: false
			renderBefore: false
			renderAfter: false
			generateBefore: false
			generateAfter: false
		copy:
			raw:
				src: 'raw'

	# =================================
	# Collections

	# Here we define our custom collections
	# What we do is we use findAllLive to find a subset of documents from the parent collection
	# creating a live collection out of it
	# A live collection is a collection that constantly stays up to date
	# You can learn more about live collections and querying via
	# http://bevry.me/queryengine/guide

	#collections:

		# Create a collection called posts
		# That contains all the documents that will be going to the out path posts

		#docs: ->
		#	@getCollection('documents').findAllLive({url: $startsWith: '/docs'}).on "add", (model) ->
		#		model.setMetaDefaults({layout:"docs"})

	collections:
		blog: ->
			# get all posts by «kind», sort them by «created_at» and set to all «layout»
			@getCollection("html").findAllLive({url: $startsWith: '/blog/'},[{created_at:-1}]).on "add", (model) ->
				model.setMetaDefaults({layout:"article"})

	# =================================
	# Environments

	# DocPad's default environment is the production environment
	# The development environment, actually extends from the production environment

	# The following overrides our production url in our development environment with false
	# This allows DocPad's to use it's own calculated site URL instead, due to the falsey value
	# This allows <%- @site.url %> in our template data to work correctly, regardless what environment we are in

	environments:
		development:
			templateData:
				site:
					url: 'http://localhost:9999'
			port: 9999

	# =================================
	# DocPad Events

	# Here we can define handlers for events that DocPad fires
	# You can find a full listing of events on the DocPad Wiki

	events:

		# Server Extend
		# Used to add our own custom routes to the server before the docpad routes are added
		serverExtend: (opts) ->
			# Extract the server from the options
			{server} = opts
			docpad = @docpad

			# As we are now running in an event,
			# ensure we are using the latest copy of the docpad configuraiton
			# and fetch our urls from it
			latestConfig = docpad.getConfig()
			oldUrls = latestConfig.templateData.site.oldUrls or []
			newUrl = latestConfig.templateData.site.url

			# Redirect any requests accessing one of our sites oldUrls to the new site url
			server.use (req,res,next) ->
				if req.headers.host in oldUrls
					res.redirect(newUrl+req.url, 301)
				else
					next()

}

# Export the DocPad Configuration
module.exports = docpadConfig
