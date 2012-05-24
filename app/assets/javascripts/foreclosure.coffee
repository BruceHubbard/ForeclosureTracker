$ -> 
	appraisedSlider = $('.appraised-range .slider').slider(
		range: true,
		min: 0,
		max: 500000,
		step: 20000,
		values: [0,500000],
		slide: (event, ui) -> 
		 	$('.appraised-range .min').text ui.values[0]
		 	$('.appraised-range .max').text ui.values[1]
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
				$('#listing').html(html)
		)
	
	refreshAuctions()