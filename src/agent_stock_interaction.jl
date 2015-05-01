"""
Functions and types for interacting model components
Justin Angevaare
April 2015
"""

type environment_assumptions
  """
  A specialized type which contains layers of information to indicate spawning area, habitat type, and additional risks
  """
  id::Array
  spawning::Array
  habitat::Array
  risk::Array
end

function spawn!(agent_db::DataFrame, stock_db::stock_db, stock_assumptions::stock_assumptions, environment_assumptions::environment_assumptions, cohort::Int)
  """
  This function creates a new cohort of agents based on an structured adult population, spawning area information contained in a `environment_assumptions`, and `stock_assumptions`.
  """
  brood_size = rand(Poisson(stock_assumptions.mean_brood_size[1]), rand(Binomial(stock_db.population[end,1], stock_assumptions.proportion_sexually_mature[1]*0.5)))
  for i = 2:length(stock_assumptions.proportion_sexually_mature)
    append!(brood_size, rand(Poisson(stock_assumptions.mean_brood_size[i]), rand(Binomial(stock_db.population[end,i], stock_assumptions.proportion_sexually_mature[i]*0.5))))
  end
  brood_location = sample(environment_assumptions.id[environment_assumptions.spawning], length(brood_size))
  agent_db[cohort,1] = DataFrame(stage=fill(1, length(brood_size)), location=brood_location, alive=brood_size, dead_natural=fill(0, length(brood_size)), dead_risk=fill(0, length(brood_size)))
  return agent_db
end

function graduate!(agent_db::DataFrame, stock_db::stock_db, agent_assumptions::agent_assumptions, cohort::Int, week::Int)
  """
  This function will advance an agent currently in a specified stage to its next life stage. If this function is applied to juveniles, it will also add their information to the stock_db
  """
  if any(agent_assumptions.growth .== week)
    for i = 1:length(agent_db[cohort, week][:stage])
      if week == agent_assumptions.growth[agent_db[cohort, week][:stage][i]]
        agent_db[cohort, week][:stage][i] += 1
        if week == agent_assumptions.growth[end]
          stock_db.population[:end, 1] += agent_db[cohort, week][:alive][i]
        end
      end
    end
  end
end
