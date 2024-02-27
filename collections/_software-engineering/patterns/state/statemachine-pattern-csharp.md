---
layout: single
---

Using this nuget [package](https://github.com/dotnet-state-machine/stateless)

This example utilizes the stateless state machine and adds a state to it. 

![state-machine-diagram](/assets/images/software-engineering/patterns/statemachine.PNG)

```
using Stateless;
using Stateless.Reflection;

/**
 * Documentation about stateless state machine: https://github.com/dotnet-state-machine/stateless
 */
public class OnboardingStateMachine
{
    private readonly StateMachine<UserStatus, OnboardingAction> _onboardingStateMachine;
    private readonly IUserPort _userPort;
    private readonly string _state;
    private readonly IOnboardingPort _onboardPort;
    private readonly StateMachine<UserStatus, OnboardingAction>.TriggerWithParameters<User> _userAlreadyExistsTrigger;
    private readonly StateMachine<UserStatus, OnboardingAction>.TriggerWithParameters<Profile> _onboardedTrigger;

    public OnboardingStateMachine(IOnboardingPort onboardPort, IUserPort userPort, string state)
    {
        _onboardPort = onboardPort;
        _userPort = userPort;
        _state = state;
        
        _onboardingStateMachine = new StateMachine<UserStatus, OnboardingAction>(InitialState);
        
        _userAlreadyExistsTrigger = _onboardingStateMachine.SetTriggerParameters<User>(UserExistsTrigger);
        _onboardedTrigger = _onboardingStateMachine.SetTriggerParameters<Profile>(OnboardedTrigger);
        
        InitStateMachine(_onboardingStateMachine);
    }

    private void InitStateMachine(StateMachine<UserStatus, OnboardingAction> stateMachine)
    {
        // PreOnboard state (and its sub-states) is the starting point. If the machine ends in one of these, no engagement-user got persisted.
        stateMachine.Configure(PreOnboarded);
        
        stateMachine.Configure(InitialState)
            .SubstateOf(PreOnboarded)
            .Permit(CheckIfUserExistsTrigger, UserCheck);
        
        stateMachine.Configure(UserCheck)
            .SubstateOf(PreOnboarded)
            .OnEntry(CheckUserExistsEntryAction)
            .PermitDynamicIf(_userAlreadyExistsTrigger, user => user.Status)
            .Permit(ValidateTrigger, NoUser)
            .Permit(FailPreOnboardingTrigger, PreOnboardFailed);
        
        // Following three states are the "real" states. They get persisted
        stateMachine.Configure(OnboardingRequested)
            .OnEntryFrom(_onboardedTrigger, VerifyOnboardingEntryAction)
            .OnEntryFrom(_userAlreadyExistsTrigger, VerifyOnboardingEntryAction)
            .Permit(CiamAccountVerifiedTrigger, CreatedInCiam);
    }

    public CustomerOnboardingResult Activate()
    {
        _onboardingStateMachine.Fire(CheckIfUserExistsTrigger);
        
        if (_onboardingStateMachine.IsInState(PreOnboarded))
        {
            return new CustomerOnboardingResult(Status: PreOnboardFailed, MergeId: _state);
        }
        return new CustomerOnboardingResult(_onboardingStateMachine.State, _state);
    }

   
    private void CheckUserExistsEntryAction()
    {
        var userId = GetUserId(_state);
        if (userId != null)
        {
            var user = _userPort.GetEngagementUser(userId.Value);
            if (user == null) return;
            _onboardingStateMachine.Fire(_userAlreadyExistsTrigger, user);
            return;
        }

        _onboardingStateMachine.Fire(ValidateTrigger);
    }

    private Guid? GetUserId(string mergeId)
    {
        var engagementId = _userPort.CheckEngagementUserExists(mergeId);
        return engagementId;
    }
    
    private void VerifyOnboardingEntryAction(Profile profile)
    {
        var newUser = _userPort.CreateUser(profile);

        if (_onboardPort.CheckUserExists(newUser))
        {
            _onboardingStateMachine.Fire(CiamAccountVerifiedTrigger);
        }
    }
    
    private void VerifyOnboardingEntryAction(User user)
    {
        if (_onboardPort.CheckUserExists(user.EngagementId))
        {
            _onboardingStateMachine.Fire(CiamAccountVerifiedTrigger);
        }
    }
    
    public StateMachineInfo GetInfo()
    {
        return _onboardingStateMachine.GetInfo();
    }
}
```