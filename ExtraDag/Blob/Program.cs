
using Blob;

Console.Write("Hej!");

var context = new BlobContext();

//RecreateDatabase();

//AddLisa();

//InsertCustomerWithImage();

//ReadCustomerAndWriteFile(2, "images\\output.jpg");

void ReadCustomerAndWriteFile(int customerId, string outputFilename)
{
    Customer customer = context.Customers.Single(c=>c.Id == customerId);
    Console.WriteLine($"Läst in {customer.Name} som har id {customer.Id}");

    Console.WriteLine($"Spara bild till {outputFilename}");

    File.WriteAllBytes(outputFilename, customer.ImageData);
}

void InsertCustomerWithImage()
{
    Console.WriteLine("Lägger till kund med bild");
    byte[]? data = File.ReadAllBytes(@"images\kalle.jpg");

    context.Customers.Add(new Customer
    {
        Created = DateTime.Now,
        Name = "Kalle",
        ImageData = data,
    });
    context.SaveChanges();
}

void AddLisa()
{
    Console.WriteLine("Lägger till Lisa");

    context.Customers.Add(new Customer
    {
        Created = DateTime.Now,
        Name = "Lisa"
    });
    context.SaveChanges();
}

void RecreateDatabase()
{
    Console.WriteLine("Återskapar databasen");
    context.Database.EnsureDeleted();
    context.Database.EnsureCreated();
}