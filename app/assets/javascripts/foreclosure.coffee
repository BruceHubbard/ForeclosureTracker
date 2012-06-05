$ -> 
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
	
	refreshAuctions = -> 
		params = {
			appraised_min: appraisedSlider.slider("values")[0],
			appraised_max: appraisedSlider.slider("values")[1]
		}
		
		$.ajax(
			url: "auction",
			data: params,
			success: (data) -> 
				html = HandlebarsTemplates['listing']({auctions: data})
				$('.listing tbody').html(html)
				$('.navbar .num-matches').text data.length + " matches"
		)

	Handlebars.registerHelper('money', (amount) ->
		return amount.toMoney(0);
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
	
