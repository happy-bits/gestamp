using Microsoft.EntityFrameworkCore;

namespace Blob;

public class BlobContext: DbContext
{
    public DbSet<Customer>? Customers { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            optionsBuilder.UseSqlServer(@"Server=localhost; Database=BlobProject; Trusted_Connection=True");
        }
    }
}
