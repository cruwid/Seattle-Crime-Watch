var dataset = [ 5, 10, 15, 20, 25 ];
		var w = 1500;
		var h = 1000;
		var padding = 50;
		var barPadding = 1;
		var rectSize = 50;
		var rectWidth = 40;
		var rectHeight = rectWidth * 1.6;
		var frontPadding = 100;
		
		//Data
		var dataset = [ 17, 10, 13, 4, 9, 25, 22 ];
		var weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		var crimes = [
    		{ day: "Monday", time: 0, crime: 12, },
    		{ day: "Tuesday", time: 0, crime: 32, },
    		{ day: "Wednesday", time: 0, crime: 37, },
    		{ day: "Thursday", time: 0, crime: 21, },
    		{ day: "Friday", time: 0, crime: 78, },
    		{ day: "Saturday", time: 0, crime: 47, },
    		{ day: "Sunday", time: 0, crime: 15, },
    		{ day: "Monday", time: 1, crime: 18, },
    		{ day: "Tuesday", time: 1, crime: 39, },
    		{ day: "Wednesday", time: 1, crime: 44, },
    		{ day: "Thursday", time: 1, crime: 29, },
    		{ day: "Friday", time: 1, crime: 63, },
    		{ day: "Saturday", time: 1, crime: 41, },
    		{ day: "Sunday", time: 1, crime: 9, },	
    			];
			
			
			// crimes.push({ day: "otehrday", time:0, crime:1, })
			
		var colorScale = d3.scale.linear()
        				.domain([0, d3.max(crimes, function(d) { return d.crime; })])
                     	.range([0, 255]);

		var maxCrime = d3.max(crimes, function(d) { return d.crime; });
			
		var scale = d3.scale.linear()
                    .domain([100, 500])
                    .range([10, 350]);
			
		//Create SVG element
		var weeklyCrime = d3.select("#weeklyCrime")
					.append("svg:svg")
					.attr("width", w + padding * 2)
					.attr("height", h + padding * 2);


		// create a group to hold the axis-related elements
		var axisGroup = weeklyCrime.append("svg:g").
  		attr("transform", "translate("+padding+","+padding+")");

		// Print y axis
		var yAxisTicks = axisGroup.selectAll("rect").
						 data(weekdays).
						 enter().
						 append("rect").
						 attr("x", 0).
						 attr("y", function(d, i) { return i * rectHeight + rectHeight / 4; }).
						 attr("width", 24 * rectWidth + 2 * frontPadding).
			   			 attr("height", rectHeight / 2).
			   			 attr("fill", "white").
			   		 	 attr("stroke", "lightgray").
			   			 attr("stroke-width", "0.5");
		
		// Print Weekday on Left
		var printWeekdayLeft = axisGroup.selectAll("text.weekdays").
			   			   	   data(weekdays).
			   			       enter().
			   			   	   append("text").
			   			   	   text(function(d) { return d; }).
			   			   	   attr("text-anchor", "end").
			   			   	   attr("x", frontPadding/1.1).
			   			   	   attr("y", function(d, i) { return i * rectHeight + rectHeight/2; }).
			   			   	   attr("dy", "5").
			   			   	   attr("font-family", "sans-serif").
			   			   	   attr("font-size", "14px").
			   			   	   attr("fill", "darkGrey");

		// Print Weekday on Right
		var printWeekdayRight = axisGroup.selectAll("text.weekdays").
			   			   data(weekdays).
			   			   enter().
			   			   append("text").
			   			   text(function(d) { return d; }).
			   			   attr("text-anchor", "start").
			   			   attr("x", 24 * rectWidth + 1.1 * frontPadding).
			   			   attr("y", function(d, i) { return i * rectHeight + rectHeight/2; }).
			   			   attr("dy", "5").
			   			   attr("font-family", "sans-serif").
			   			   attr("font-size", "14px").
			   			   attr("fill", "darkGrey");
		
		
		// Print x axis
		var xAxisTicks = axisGroup.selectAll(".xTicks").
 						 data(d3.range(0, 25)).
 						 enter().append("svg:line").
  						 attr("x1", function(d) { return d * rectWidth + frontPadding; }).
  						 attr("y1", getXAxisTicksFront).
  						 attr("x2", function(d) { return d * rectWidth + frontPadding; }).
  						 attr("y2", getXAxisTicksEnd).
  						 attr("stroke", "lightgray").
  						 attr("stroke-width", "0.5px").
  						 attr("class", "xTicks");

		function getXAxisTicksEnd(d) {
			if (d % 2 == 0) {
				return 7 * rectHeight + 10;
			} else {
				return 7 * rectHeight + 25;
			}
		}
		
		function getXAxisTicksFront(d) {
			if (d % 2 == 0) {
				return -10;
			} else {
				return -25;
			}
		} 

		// Print Time in x axis
		// Print Time on Top
		var printTimeTop = axisGroup.selectAll("text.xAxisBottom").
						   data(d3.range(0,25)).
			   			   enter().
			   			   append("text").
			   			   text(getTime).
			   			   attr("text-anchor", "middle").
			   			   attr("x", function(d) { return frontPadding + d * rectWidth; }).
			   			   attr("y", getTimeYTop).
			   			   attr("font-family", "sans-serif").
			   			   attr("font-size", "12px").
			   			   attr("fill", "darkGrey");
		
		// Print Time on Bottom 			
		var printTimeBottom = axisGroup.selectAll("text.xAxisBottom").
							  data(d3.range(0,25)).
			   				  enter().
			   				  append("text").
			   				  text(getTime).
			   				  attr("text-anchor", "middle").
			   				  attr("x", function(d) { return frontPadding + d * rectWidth; }).
			   				  attr("y", getTimeYBottom).
			   				  attr("font-family", "sans-serif").
			   				  attr("font-size", "12px").
			   				  attr("fill", "darkGrey");
			   			
			   			
		function getTime(d) {
			if (d < 13) {
				return d + " am";
			}else if (d == 24) {
				return 0 + " am";
			}else 
				return (d % 12) + " pm";
		}
		
		function getTimeYBottom(d) {
			if (d % 2 == 0) {
				return 7.3 * rectHeight;	
			} else {
			   	return 7.6 * rectHeight;
			}
		}
		
		function getTimeYTop(d) {
			if (d % 2 == 0) {
				return - 0.3 * rectHeight;	
			} else {
			   	return - 0.6 * rectHeight;
			}
		}
			

		// create a group to hold the heatMap elements
		var heatMapGroup = weeklyCrime.append("svg:g").
  		attr("transform", "translate("+padding+","+padding+")");
		
		
		var colorBlock = d3.scale.linear().domain([0, 255]).range(["white", "red"]);
		// var color = d3.scale.category20b();
		
		// print blocks
		var rect = heatMapGroup.selectAll("rect").
				   data(crimes).
				   enter().
				   append("rect").
				   attr("x", function(d) {return d.time * rectWidth + frontPadding;}).
				   attr("y", getRectY).
				   attr("width", rectWidth - barPadding).
			   	   attr("height", rectHeight - barPadding).
			       attr("fill", colorGradient);
			
		function colorGradient(d) {
			// return "rgb(" + (Math.floor(colorScale(d.crime)) * 2) + " , 0, " + Math.floor(colorScale(d.crime)) + ")";
			// return "rgb(" + (Math.floor(colorScale(d.crime))) + ", " + 0 + ", " + 0 + ")";
			return colorBlock(Math.floor(colorScale(d.crime)));
		}

			
		// print block number
		var PrintValues = heatMapGroup.selectAll("text.value").
			   			  data(crimes).
			   			  enter().
			   	      	  append("text").
			   			  text(function(d) { return Math.floor(colorScale(d.crime)); }).
			   			  attr("text-anchor", "middle").
			   	     	  attr("x", function(d) {return d.time * rectWidth + rectWidth/2 + frontPadding;}).
			   			  attr("y", getValueY).
			   	    	  attr("font-family", "sans-serif").
			   			  attr("font-size", "11px").
			   			  attr("fill", "white");
			

		function getValueY(d) {
			return getRectY(d) + rectHeight/3;
		}
	
	
		function getRectY(d) {
			switch(d.day) {
				case "Sunday":
					return 0;
					break;
				case "Monday":
					return 1 * rectHeight;
					break;
				case "Tuesday":
					return 2 * rectHeight;
					break;
				case "Wednesday":
					return 3 * rectHeight;
					break;
				case "Thursday":
					return 4 * rectHeight;
					break;
				case "Friday":
					return 5 * rectHeight;
					break;
				case "Saturday":
					return 6 * rectHeight;
					break;
				}
		}