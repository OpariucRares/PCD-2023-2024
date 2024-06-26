﻿using Dogo.Application;
using Dogo.Core.Repositories;
using Dogo.Core.Repositories.Base;
using Dogo.Infrastructure.Data;
using Dogo.Infrastructure.Repositories;
using Dogo.Infrastructure.Repositories.Base;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Dogo.Infrastructure
{
	public static class ConfigureServices
	{
		public static IServiceCollection AddInfrastrutureServices(this IServiceCollection services, IConfiguration configuration)
		{
			services.AddSignalR();

			services.AddScoped(typeof(IRepository<>), typeof(Repository<>));
			services.AddScoped(typeof(IUnitOfWork), typeof(UnitOfWork));
			services.AddScoped<IUserRepository, UserRepository>();
			services.AddScoped<IPetRepository, PetRepository>();
			services.AddScoped<IAddressRepository, AddressRepository>();
			services.AddScoped<IAppointmentRepository, AppointmentRepository>();

			services.AddDbContext<DatabaseContext>(m => m.UseSqlServer(configuration.GetConnectionString("DogoDB")), ServiceLifetime.Singleton);

			return services;
		}
	}
}