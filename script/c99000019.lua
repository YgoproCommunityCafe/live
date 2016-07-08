--?æ©Ÿè²¨åˆ—è»Šãƒ‡?ªãƒƒ??ƒ¬?¼ãƒ³
function c99000019.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99000019,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,99000019)
	e1:SetCondition(c99000019.spcon)
	e1:SetTarget(c99000019.sptg)
	e1:SetOperation(c99000019.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--20spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(99000019,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c99000019.sspcon)
	e3:SetTarget(c99000019.ssptg)
	e3:SetOperation(c99000019.sspop)
	c:RegisterEffect(e3)
	--cannot release
	local ea=Effect.CreateEffect(c)
	ea:SetType(EFFECT_TYPE_SINGLE)
	ea:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ea:SetRange(LOCATION_MZONE)
	ea:SetCode(EFFECT_UNRELEASABLE_SUM)
	ea:SetValue(1)
	c:RegisterEffect(ea)
	local eb=ea:Clone()
	eb:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(eb)
end
function c99000019.spfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:GetLevel()==20
end
function c99000019.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c99000019.spfilter,1,nil,tp)
end
function c99000019.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c99000019.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
		local atk=c:GetBaseAttack()
		local def=c:GetBaseDefence()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(atk/2)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENCE)
		e2:SetValue(def/2)
		c:RegisterEffect(e2)
		Duel.SpecialSummonComplete()
	end
end
function c99000019.sspcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_COST) and re:IsHasType(0x7e0) and re:IsActiveType(TYPE_MONSTER)
		and bit.band(c:GetPreviousLocation(),LOCATION_OVERLAY)~=0
end
function c99000019.filter(c,e,tp)
	return c:GetLevel()==20 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c99000019.ssptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c99000019.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c99000019.sspop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c99000019.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end