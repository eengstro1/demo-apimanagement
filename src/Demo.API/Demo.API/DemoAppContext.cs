using Microsoft.EntityFrameworkCore;
using Demo.API.Models;

namespace Demo.API
{
    public class DemoAppContext : DbContext
    {
        public DemoAppContext(DbContextOptions<DemoAppContext> options)
            : base(options)
        {
        }

        public DbSet<Pet> Pets { get; set; }
    }
}
