USE [StudentCourses]
GO

/****** Object:  View [db_owner].[vwInstructorCourseDepartment]    Script Date: 5/6/2021 8:21:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [db_owner].[vwInstructorCourseDepartment]
AS
SELECT p.PersonID, p.LastName, p.FirstName, p.HireDate, p.Discriminator, c.CourseID, c.Title, c.Credits, d.Name, d.Budget, d.StartDate, oc.Location, oc.Days, ol.URL
FROM     dbo.Course AS c RIGHT OUTER JOIN
                  dbo.Person AS p LEFT OUTER JOIN
                  dbo.CourseInstructor AS ci ON ci.PersonID = p.PersonID ON c.CourseID = ci.CourseID LEFT OUTER JOIN
                  dbo.Department AS d ON d.DepartmentID = c.DepartmentID LEFT OUTER JOIN
                  dbo.OnsiteCourse AS oc ON c.CourseID = oc.CourseID LEFT OUTER JOIN
                  dbo.OnlineCourse AS ol ON c.CourseID = ol.CourseID
WHERE  (p.Discriminator = 'Instructor')
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[15] 2[25] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "p"
            Begin Extent = 
               Top = 169
               Left = 14
               Bottom = 332
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "ci"
            Begin Extent = 
               Top = 7
               Left = 295
               Bottom = 193
               Right = 489
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 111
               Left = 597
               Bottom = 318
               Right = 791
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 287
               Left = 869
               Bottom = 450
               Right = 1063
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "oc"
            Begin Extent = 
               Top = 17
               Left = 870
               Bottom = 180
               Right = 1064
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ol"
            Begin Extent = 
               Top = 320
               Left = 300
               Bottom = 439
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 18
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         W' , @level0type=N'SCHEMA',@level0name=N'db_owner', @level1type=N'VIEW',@level1name=N'vwInstructorCourseDepartment'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'idth = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'db_owner', @level1type=N'VIEW',@level1name=N'vwInstructorCourseDepartment'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'db_owner', @level1type=N'VIEW',@level1name=N'vwInstructorCourseDepartment'
GO

