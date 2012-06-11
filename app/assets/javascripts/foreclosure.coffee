up_arr = "▴"
down_arr = "▾"

$ -> 
	lastResult = null
	
	appraisedSlider = $('.appraised-range .slider').slider(
		range: true,
		min: 0,
		max: 500000,
		step: 20000,
		values: [0,500000],
		slide: (event, ui) -> 
		 	$('.appraised-range .min').text ui.values[0].toMoney(0)
		 	$('.appraised-range .max').text ui.values[1].toMoney(0)
		stop: (event, ui) ->
			refreshAuctions()
	)
	
	$('.show-old input').change(() -> refreshAuctions())
	
	refreshAuctions = -> 
		params = {
			appraised_min: appraisedSlider.slider("values")[0],
			appraised_max: appraisedSlider.slider("values")[1],
			showOld: $('input[name=showOld]:checked').val()
		}
		
		sort = $('.listing table th .sort-dir')
		
		if(sort.length > 0) 
			params.sortProp = sort.closest('th').data('prop')
			params.sortDir = if sort.hasClass('asc') then 'asc' else 'desc'
		
		$.ajax(
			url: "auction",
			data: params,
			success: (data) -> 
				lastResult = data
				redrawAuctions(data)
		)
	
	redrawAuctions = (result) -> 
		viewType = $('input[name=showAs]:checked').val()
		
		if viewType == 'list' 
			$('.map').hide()
			$('.listing').show()
			html = HandlebarsTemplates['listing']({auctions: result})
			$('.listing tbody').html(html)
		else
			$('.listing').hide()
			$('.map').show()
			addMap(result)
			
		$('.navbar .num-matches').text result.length + " matches"
	
	addMap = (auctions) -> 
		map = new GMaps({
		        div: '#map',
		        lat: 39.343333,
		        lng: -84.528333,
				zoom: 11
		      });
		
		haveRealCoords = (a for a in auctions when a.hasValidAddress)
		
		for a in haveRealCoords
			map.addMarker({
				lat: a.latitude,
				lng: a.longitude,
				title: a.fullAddress
			})
			
		map.fitZoom()
		
		
		
	$(".show-old .button-group").buttonset()
	$(".show-as .button-group").buttonset()

	$('.listing table th').click(() -> 
		that = this;
		arrow = $(this).find('.sort-dir')
		if(arrow.length > 0)
			if(arrow.hasClass('asc'))
				arrow.removeClass('asc').addClass('desc').text(down_arr)
			else if(arrow.hasClass('desc')) 
				arrow.removeClass('desc').addClass('asc').text(up_arr)		
		else
			$('.listing table th .sort-dir').remove()
			$(this).append($('<span class="sort-dir asc">' + up_arr + '</span>'))
			
		refreshAuctions()
	)
	
	$('.show-as input').click(() -> 
		redrawAuctions(lastResult)
	)

	Handlebars.registerHelper('money', (amount) ->
		return amount.toMoney(0);
	)	
	
	Handlebars.registerHelper('prettyDate', (date) -> 
		d = new Date(Date.parse(date))
		(d.getMonth() + 1) + '/' + (d.getDate() + 1) + '/' + d.getFullYear()
	)
	
	Number.prototype.toMoney = (decimals = 2, decimal_separator = ".", thousands_separator = ",") ->
		n = this
		c = if isNaN(decimals) then 2 else Math.abs decimals
		sign = if n < 0 then "-" else ""
		i = parseInt(n = Math.abs(n).toFixed(c)) + ''
		j = if (j = i.length) > 3 then j % 3 else 0
		x = if j then i.substr(0, j) + thousands_separator else ''
		y = i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands_separator)
		z = if c then decimal_separator + Math.abs(n - i).toFixed(c).slice(2) else ''
		sign + x + y + z

	refreshAuctions()
	
