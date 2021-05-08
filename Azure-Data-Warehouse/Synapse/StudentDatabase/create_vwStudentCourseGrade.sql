USE [StudentCourses]
GO

/****** Object:  View [db_owner].[vwStudentCourseGrade]    Script Date: 5/6/2021 8:20:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [db_owner].[vwStudentCourseGrade]
AS
SELECT p.PersonID, p.LastName, p.FirstName, p.EnrollmentDate, p.Discriminator, c.CourseID, c.Title, c.Credits, sg.Grade, oc.Location, oc.Days, ol.URL
FROM     dbo.Person AS p LEFT OUTER JOIN
                  dbo.StudentGrade AS sg ON sg.StudentID = p.PersonID AND sg.StudentID = p.PersonID RIGHT OUTER JOIN
                  dbo.Course AS c ON sg.CourseID = c.CourseID LEFT OUTER JOIN
                  dbo.OnsiteCourse AS oc ON c.CourseID = oc.CourseID LEFT OUTER JOIN
                  dbo.OnlineCourse AS ol ON c.CourseID = ol.CourseID
WHERE  (p.Discriminator = 'Student')
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
               Top = 20
               Left = 1001
               Bottom = 183
               Right = 1200
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sg"
            Begin Extent = 
               Top = 17
               Left = 670
               Bottom = 180
               Right = 864
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "oc"
            Begin Extent = 
               Top = 290
               Left = 14
               Bottom = 453
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ol"
            Begin Extent = 
               Top = 25
               Left = 5
               Bottom = 144
               Right = 199
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 26
               Left = 353
               Bottom = 189
               Right = 547
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
      Begin ColumnWidths = 19
         Width = 284
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
         Width = 1200
         Width = ' , @level0type=N'SCHEMA',@level0name=N'db_owner', @level1type=N'VIEW',@level1name=N'vwStudentCourseGrade'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'1200
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
' , @level0type=N'SCHEMA',@level0name=N'db_owner', @level1type=N'VIEW',@level1name=N'vwStudentCourseGrade'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'db_owner', @level1type=N'VIEW',@level1name=N'vwStudentCourseGrade'
GO

