using ChartExample.Models;
using ChartExample.Models.Chart;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json;
using System;

namespace ChartExample.ViewComponents
{
    [ViewComponent(Name = "chartjs")]
    public class ChartJsViewComponent : ViewComponent
    {
        public IViewComponentResult Invoke()
        {

            double[] chartdt = new double[9];
            try
            {
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
                builder.DataSource = "loanstarpoc.database.windows.net";
                builder.UserID = "alvianda";
                builder.Password = "Finastra2021!";
                builder.InitialCatalog = "StudentDW";

                using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {
                    string sql = "select title as courseTitle,count(PersonID) as studentCount, avg(grade) as avgGrade ";
                    sql += "from allcourses.info ";
                    sql += "GROUP BY title; ";

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            var i = 0;
                            while (reader.Read())
                            {
                                Console.WriteLine("{0}...{1}...{2}", reader.GetString(0), reader.GetInt32(1), Math.Round(reader.GetDouble(2),2));
                                chartdt[i] = (double)reader.GetInt32(1);
                                i++;
                                
                            }
                        }
                    }
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine(e.ToString());
            }


            // Ref: https://www.chartjs.org/docs/latest/
            var chartvals = $"[{string.Join(',', chartdt)}]";
            //var chartvals = "[2,3,4,5,6,7]";
            var chartData = @"
            {
                type: 'bar',
                responsive: true,
                data:
                {
                    labels: ['Calculus', 'Chemistry', 'Physics', 'Composition', 'Poetry', 'Literature', 'Microeconomics', 'Macroeconomics', 'Quantitative'],
                    datasets: [{
                        data: " + chartvals + @",
                        backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)'
                            ],
                        borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)',
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)'
                            ],
                        borderWidth: 1
                    }]
                },
                options:
                {
                    scales:
                    {
                        yAxes: [{
                            ticks:
                            {
                                beginAtZero: true
                            }
                        }]
                    }
                }
            }";

            var chart = JsonConvert.DeserializeObject<ChartJs>(chartData);
            var t = new Title
            {
                text = "Course Student Attendance",
                display = true
            };

            chart.title = t;
            
            var chartModel = new ChartJsViewModel
            {
                Chart = chart,
                ChartJson = JsonConvert.SerializeObject(chart, new JsonSerializerSettings
                {
                    NullValueHandling = NullValueHandling.Ignore,
                    
                })
            };

            return View(chartModel);
        }
    }
}