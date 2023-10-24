import React, { useState, useEffect } from 'react';
import c3 from 'c3';
import 'c3/c3.css';
import axios from 'axios';

const Chart = () => {
  const [chartData, setChartData] = useState(null);

  useEffect(() => {
    // Initialize data
    const fetchData = async () => {
      try {
        // Process the response data and update the chart data
        setChartData({
          x: 'x',
          columns: [
            ['x', []], // Assuming an array of date strings in response.data
            ['usd', []], // Assuming an array of data points in response.data.data1
            ['eur', []], // Assuming an array of data points in response.data.data2
          ],
        });
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData(); // Fetch data when the component mounts
  }, []);

  useEffect(() => {
    if (chartData) {
      // Chart configuration
      const chartConfig = {
        bindto: '#chart', // Specify the HTML element to bind the chart to
        data: chartData,
        axis: {
          x: {
            type: 'timeseries',
            tick: {
              format: '%Y-%m-%d',
            },
          },
        },
      };

      // Generate the chart
      const chart = c3.generate(chartConfig);

      // Load additional data after a delay
      setTimeout( async () => {
        const response = await axios.get(`${process.env.REACT_APP_BASE_API_URL}/list`);
        chart.load({
          columns: [
            ['x', ...response.data.map(item => item.date)],
            ['usd', ...response.data.map(item => parseFloat(item.dollar))],
            ['eur', ...response.data.map(item => parseFloat(item.euro))],
          ],
        });
      }, 500);
    }
  }, [chartData]);

  return (
    <div id="chart" />
  );
};

export default Chart;
