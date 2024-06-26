﻿using Dogo.Application.Response;
using Dogo.Core.Helpers;
using MediatR;

namespace Dogo.Application.Queries.Appointment
{
    public class GetAgendaOfUserQuery : IRequest<ResultOfEntity<List<AppointmentResponse>>>
    {
        public Guid UserId { get; set; }
    }
}
