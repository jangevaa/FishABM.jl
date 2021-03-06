"""
types.jl
Type definitions for the structured stock-level and agent-level model components
"""

type AgentAssumptions
  """
  Assumptions regarding mortality, movement, and growth
  """
  naturalmortality::Array
  extramortality::Vector
  growth::Vector
  movement::Array
  autonomy::Vector
end

type EnvironmentAssumptions
  """
  A specialized type which contains layers of information to indicate spawning area, habitat type, and additional risks. location id should be specified as NaN when a valid location does not exist.
  """
  spawning::Array
  habitat::Array
  risk::Array
end

type StockDB
  """
  A database which contains population size data for each time step and adult class
  """
  population::DataFrame
  harvest::DataFrame
end

type StockAssumptions
  """
  Age specific survivorship (survivorship at carrying capacity if density depedence occurs)
  Age at 50% mature (Binomial cdf assumed)
  Age specific fecundity (i.e. mean quantity of eggs each spawning female will produce)
  Compensatory fecundity - compensatory strength for changes in fecundity. Compensatory strength is a divisor of K which will result in a 68% change in fecundity - smaller values indicate lower compensation strength. Compensation function based on Normal CDF. Use NaN if compensation is assumed to not occur.
  Compensatory sexual maturity - compensatory strength for changes in age of sexual maturity. Compensatory strength is a divisor of K which will result in a 68% change in age of sexual maturity - smaller values indicate lower compensation strength. Compensation function based on Normal CDF. Use NaN if compensation is assumed to not occur.
  Compensatory mortality - compensatory strength for changes in age of sexual maturity. Compensatory strength is a divisor of K which will result in a 68% change in natural mortality - smaller values indicate lower compensation strength. Compensation function based on Normal CDF. Use NaN if compensation is assumed to not occur.
Age specific catachability
  """
  naturalmortality::Vector
  halfmature::Float64
  broodsize::Vector
  fecunditycompensation::Float64
  maturitycompensation::Float64
  mortalitycompensation::Float64
  catchability::Vector
end
