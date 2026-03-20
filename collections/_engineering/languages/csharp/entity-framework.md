---
layout: single
---

# Setup
After you defined your DB context you can run these commands:

cd into where your Program.cs resides. 

Install Design package: 

```
dotnet add package Microsoft.EntityFrameworkCore.Design
```

Run the first migration: 
```
dotnet ef migrations add InitialCreate
```

# database update

```
C:\Git\DAW.MW.Admin>dotnet ef database update --project "DAW.MW.Admin.DAL.Application" --startup-project "DAW.MW.Admin" --context ApplicationDBContext -- --environment Development
```

# Relationships

By default, a relationship will be created when there is a navigation property discovered on a type

```
public class Blog
{
    public int BlogId { get; set; }
    public string Url { get; set; }

    // defines the dependent entity (Posts) in the principal entity (Blog)
    public List<Post> Posts { get; set; }
}

public class Post
{
    public int PostId { get; set; }
    public string Title { get; set; }
    public string Content { get; set; }

    // Post.BlogId is the foreignKey
    public int BlogId { get; set; }
    // Post.Blog is a reference navigation property
    public Blog Blog { get; set; }
}
```

EF Core cannot set navigation properties (such as Blog or Posts above) using a constructor.
So using constructors, best you can do is:

```
public class Blog
{
    public Blog(int id, string name, string author)
    {
        Id = id;
        Name = name;
        Author = author;
    }

    public int Id { get; set; }

    public string Name { get; set; }
    public string Author { get; set; }

    public ICollection<Post> Posts { get; } = new List<Post>();
}

public class Post
{
    public Post(int id, string title, DateTime postedOn)
    {
        Id = id;
        Title = title;
        PostedOn = postedOn;
    }

    public int Id { get; set; }

    public string Title { get; set; }
    public string Content { get; set; }
    public DateTime PostedOn { get; set; }

    public Blog Blog { get; set; }
}
```